import extras.*
import wollok.game.*
import posiciones.*
import personajes.personaje.*
import sonidos.*

object managerZombie {
    const property zombies = #{}

    method quitarZ(zombie) {
        zombies.remove(zombie)
    }

    method spawnearZComun() {
        const zombieSpawneado = new Perro(position = game.at(game.width() -2, game.height() -2))
        zombies.add(zombieSpawneado)
        game.addVisual(zombieSpawneado)
        zombieSpawneado.persecucion()
    }

    method posTieneZombie(pos) {
        return (zombies.any({zom => zom.position() == pos}))
    }
    
}

class Zombie {
    var property image
    var property position
    var property vida
    const property dmg
    const property velocidad

    method agro() {
        return personaje
    }

    method colisionPj() {}

    method nombreEvento() {
        return "evento" + self.identity()
    }

    method persecucion() {
        game.onTick(velocidad, self.nombreEvento(), {self.perseguirAPersonaje()})
    }

    method impactoProyectil(danio) {
        vida = 0.max(vida - danio)
        self.sonidoHerida()
        self.fijarseMuerte()
    }
    
    method fijarseMuerte() {
        if (vida == 0) {
           self.morir() 
        }
    }

    method atacarAgro() {
        self.imagenHacia(self.dirAgroPegado())
        self.agro().herir(dmg)
    }

    method sonidoHerida()
    method sonidoMuerte()

    // Persecucion -------------------------------------

    method perseguirAPersonaje() {
        if (self.agroEstaPegado()) {
            self.atacarAgro()
        }
        else {
            image = self.imagenHacia(self.dirDeTransicionA(self.sigPosFavorable()))
            position = self.sigPosFavorable()
        }
    }

    method agroEstaPegado() {
        return self.position().distance(self.agro().position()) == 1
    }

    method dirDeTransicionA(pos) {
        if (pos.x() > position.x()) {
            return derecha
        }
        else if (pos.x() < position.x()) {
            return izquierda
        }
        else if (pos.y() > position.y()) {
            return arriba
        }
        else { return abajo}
    }

    method sigPosFavorable() {
        const disponibles = tablero.alrededoresDe(self).filter({pos => not(managerZombie.posTieneZombie(pos))})
        return disponibles.min({pos => pos.distance(self.agro().position())})
    }

    method dirAgroPegado() {
        if (self.distanciaY() == 0 and self.distanciaX() < 0) {
            return izquierda
        }
        else if (self.distanciaY() == 0 and self.distanciaX() > 0) {
            return derecha
        }
        else if (self.distanciaX() == 0 and self.distanciaY() < 0) {
            return abajo
        }
        else {return arriba}
    }

    method distanciaX() {
        return (self.agro().position().x() - position.x())
    }

    method distanciaY() {
        return (self.agro().position().y() - position.y())
    }

    // Movimiento -------------------------------------


/*
     method moverseHaciaAgro() {
        if (self.estaDistanciaLineal()) {
            self.moverseLineal()
        } else if(self.estaDistanciaDiagonal()) {
            self.moverseDiagonal()
        }
    }

    method estaDistanciaDiagonal() {
        return 
    }

    method estaDistanciaLineal() {
        return self.position().x() == self.agro().position().x() or self.position().y() == self.agro().position().y()
    }

    method moverseLineal() {
        if (self.agro().position().x() < position.x() and self.agro().position().y() == position.y()) {
            self.moverse(izquierda)
        } else if (self.agro().position().x() > position.x() and self.agro().position().y() == position.y()) {
            self.moverse(derecha)
        } else if (self.agro().position().y() > position.y() and self.agro().position().x() == position.x()) {
            self.moverse(arriba)
        } else if (self.agro().position().y() < position.y() and self.agro().position().x() == position.x()) {
            self.moverse(abajo)
        }
    }

    method moverseDiagonal() {
        if (self.agro().position().y() > position.y() and self.agro().position().x() > position.x()) {
            self.moverse(arriba)
            game.schedule(velocidad, {self.moverse(derecha)})
        } else if (self.agro().position().y() < position.y() and self.agro().position().x() < position.x()) {
            self.moverse(abajo)
            game.schedule(velocidad, {self.moverse(izquierda)})
        } else if (self.agro().position().y() < position.y() and self.agro().position().x() > position.x()) {
            self.moverse(abajo)
            game.schedule(velocidad, {self.moverse(derecha)})
        } else if (self.agro().position().y() > position.y() and self.agro().position().x() < position.x()) {
            self.moverse(arriba)
            game.schedule(velocidad, {self.moverse(izquierda)})
        }
    }
*/

    method imagenHacia(dir) {
        return self.imagenMovimiento() + dir.toString() + ".png"
    }

    method imagenMovimiento()

    method moverse(direccion) {
	    position = direccion.siguientePosicion(self.position())
        image = self.imagenHacia(direccion)
	}

    method morir() {
        self.sonidoMuerte()
        game.removeVisual(self)
        game.removeTickEvent(self.nombreEvento())
        managerZombie.quitarZ(self)
        managerItems.spawnearMunicionEn(self.position())
    }
}

class ZombieComun inherits Zombie(vida = 100, dmg = 10, velocidad = 1000, image = "zombie-comun-abajo.png"){
    

    // Ataque -----------------------------------------

    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play()
    }

    override method imagenMovimiento() {
        return "zombie-comun-"
    }
}

class Perro inherits Zombie(vida = 50, dmg = 20,  velocidad = 700, image = "perronio-abajo.png"){


    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play()
    }

    override method imagenMovimiento() {
        return "perronio-"
    }
}

class ZombieTanque inherits Zombie(vida = 200, dmg = 50, velocidad = 1500, image = "zombie-comun-abajo.png") {
    
    override method impactoProyectil(danio) {
        super(danio * 0.75)             // recibe un 25% menos de daño (tipo por tener "armadura")
    }


    method golpearSuelo() {
        // acá hace la animación primero y luego hace el daño...
    }
   
    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play() // hay q ponerle otros sonidos para q quede mejorr
    }


    override method morir() {
        super()
        // y algo más, como que explota y hace daño una última vez o algo así...
    }

    // sonido -----------------------------------------


    // imagen -----------------------------------------

    override method imagenMovimiento() {
        return "zombie-comun-"
    }
}

class ZombieThrower inherits Zombie(vida = 20, dmg = 30, velocidad = 300, image = "zombie-comun-abajo.png"){  //velocidad normal = 1200 (300 de prueba)
    var contador = 0

    override method perseguirAPersonaje() {
        if(!self.agroEstaAbajo() and !self.estaAlFinalIzquierdo() and contador.even()) {
            self.moverse(izquierda)
        } else if(!self.agroEstaAbajo() and !self.estaAlFinalDerecho() and !contador.even()) {
            self.moverse(derecha)
        } else if (!self.agroEstaAbajo() and self.estaAlFinalDerecho()){
            contador += 1
            self.moverse(izquierda)
        } else if (!self.agroEstaAbajo() and self.estaAlFinalIzquierdo()){
            contador += 1
            self.moverse(derecha)
        }
    }

    // movimiento ------------------------------------

    method estaAlFinal() {
        return  self.estaAlFinalIzquierdo() or self.estaAlFinalDerecho()
    }

    method estaAlFinalDerecho() {
        return position.x() == game.width() - 1
    }

    method estaAlFinalIzquierdo() {
        return position.x() == 0
    }

    method agroEstaAbajo() {
        return self.agro().position().x() == self.position().x()
    }

    // ataque y colisión ------------------------------

    // sonido -----------------------------------------

    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play()
    }

    // imagen -----------------------------------------

    override method imagenMovimiento() {
        return "zombie-comun-"
    }
}