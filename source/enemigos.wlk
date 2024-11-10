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
        const zombieSpawneado = new ZombieTanque(position = game.at(game.width() -2, game.height() -2))
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

    method traspasable() {
        return false
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
        else {
            return abajo
        }
    }

    method sigPosFavorable() {
        const disponibles = tablero.alrededoresDe(position).filter({pos => not(managerZombie.posTieneZombie(pos))})
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
        else {
            return arriba
        }
    }

    method distanciaX() {
        return (self.agro().position().x() - position.x())
    }

    method distanciaY() {
        return (self.agro().position().y() - position.y())
    }

    // Movimiento -------------------------------------

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

class ZombieTanque inherits Zombie(vida = 10, dmg = 50, velocidad = 1500, image = "tanque-1-abajo.png") { // poner la vida de nuevo en 300 (es para testear)
    
    override method impactoProyectil(danio) {
        super(danio * 0.75)             // recibe un 25% menos de daño (tipo por tener "armadura")
    }

    method golpearSuelo() {
        // acá hace la animación primero y luego hace el daño...
    }

    override method morir() {
        self.explotar()
        super()
    }
    
    method explotar() {
        tablero.alrededoresDe(position).forEach({p => self.romperSuelo(p)})
        self.romperSuelo(position)
    }

    method romperSuelo(posicion) {
        const suelo = new SueloRoto(position = posicion, causante = self)
        game.addVisual(suelo)
        game.schedule(1000, game.removeVisual(suelo))
    }
   

    // sonido -----------------------------------------
    
    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play() // hay q ponerle otros sonidos para q quede mejorr
    }

    // imagen -----------------------------------------

    override method imagenMovimiento() {
        return "tanque-1-"
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

    // ataque ------------------------------

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