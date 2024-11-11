import extras.*
import wollok.game.*
import posiciones.*
import personajes.personaje.*
import sonidos.*
import proyectiles.*

object managerZombie {
    const property zombies = #{}

    method quitarZ(zombie) {
        zombies.remove(zombie)
    }

    method spawnearZ(zombie) {
        zombies.add(zombie)
        game.addVisual(zombie)
        zombie.persecucion()
    }

    method posTieneZombie(pos) {
        return (zombies.any({zom => zom.position() == pos}))
    }
}

object generadorZombie {
    method zombieTanque(posicion) {
        return new ZombieTanque(position = posicion)
    }

    method zombieComun(posicion) {
        return new ZombieComun(position = posicion)
    }

    method zombieThrower(posicion) {
        return new ZombieThrower(position = posicion)
    }

    method zombiePerro(posicion) {
        return new ZombiePerro(position = posicion)
    }
    
    method posicionInicial() {
        return game.at(game.width() -3, game.height() -3)
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

    method herir(danio) {
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
            self.imagenHacia(self.dirDeTransicionA(self.sigPosFavorable()))
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
        image = self.imagenMovimiento() + dir.toString() + ".png"
    }

    method imagenMovimiento()

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

class ZombiePerro inherits Zombie(vida = 50, dmg = 20,  velocidad = 700, image = "perronio-abajo.png"){


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

class ZombieTanque inherits Zombie(vida = 300, dmg = 50, velocidad = 1500, image = "tanque-1-abajo.png") {
    
    var estado = 1
    var ultimaDir = abajo

    override method herir(danio) {
        super(danio * 0.75)             // recibe un 25% menos de daño (Por tener "armadura")
    }

    override method atacarAgro() {
        ultimaDir = self.dirAgroPegado()
        game.removeTickEvent(self.nombreEvento())
        self.animacionAtaque() 
        game.schedule(1250,{managerCrater.explosionEnCon(position,dmg)}) 
        game.schedule(1500,{self.persecucion()})
    }

    method animacionAtaque() {
        estado = 2
        self.imagenHacia(ultimaDir)
        game.schedule(600,{estado += 1})
        game.schedule(650,{self.imagenHacia(ultimaDir)})
        game.schedule(1200,{estado += 1})
        game.schedule(1200,{self.imagenHacia(ultimaDir)})
        game.schedule(1250,{estado = 1})
        game.schedule(1450,{self.imagenHacia(ultimaDir)})
    }

    override method morir() {
        self.explotar()
        super()
    }

    method explotar() {
        managerCrater.explosionEnCon(position, dmg)
    }

    // sonido -----------------------------------------
    
    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play() // hay q ponerle otros sonidos
    }

    // imagen -----------------------------------------

    override method imagenMovimiento() {
        return "tanque-" + estado.toString() + "-"
    }
}

class ZombieThrower inherits Zombie(vida = 20, dmg = 10, velocidad = 250, image = "expectorador-1-abajo.png"){  
    var contador = 0
    var estado = 1
    var positionAtaque = game.at(0, 0)

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
        } else {
            self.atacarAPersonaje() 
        }
    }

    method atacarAPersonaje() {
        positionAtaque = self.agro().position()
        self.atacarAgro()
    }

    method moverse(dir) {
        position = dir.siguientePosicion(position)
        self.imagenHacia(dir)
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
    override method atacarAgro() {
        game.removeTickEvent(self.nombreEvento())
        self.animacionAtaque()
        game.schedule(1250,{managerAcido.acidoEnCon(positionAtaque, dmg)})
        game.schedule(1500,{self.persecucion()})    
    }

    method animacionAtaque() {
        estado = 2
        self.imagenHacia(abajo)
        game.schedule(600,{estado += 1})
        game.schedule(650,{self.imagenHacia(abajo)})
        game.schedule(1200,{estado += 1})
        game.schedule(1200,{self.imagenHacia(abajo)})
        game.schedule(1250,{estado = 1})
        game.schedule(1450,{self.imagenHacia(abajo)})
    }

    // sonido -----------------------------------------

    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play()
    }

    // imagen -----------------------------------------

    override method imagenMovimiento() {
        return "expectorador-" + estado.toString() + "-"
    }
}