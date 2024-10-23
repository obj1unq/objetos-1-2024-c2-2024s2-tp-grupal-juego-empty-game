import extras.*
import wollok.game.*
import posiciones.*
import personajes.personaje.*
import sonidos.*

object managerZombie {
    const property zombies = #{}

    method spawnearZombieComun() {
        const zombieSpawneado = new ZombieThrower(position = game.at(game.width() -2, game.height() -2))
        zombies.add(zombieSpawneado)
        game.addVisual(zombieSpawneado)
        zombieSpawneado.persecucion()
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

    method colisionPj()

    method nombreEvento() {
        return "evento" + self.identity()
    }

    method persecucion() {
        game.onTick(velocidad, self.nombreEvento(), {self.perseguirAPersonaje()})
    }

    method perseguirAPersonaje() {
        self.moverse()
        self.atacarSiPuede() 
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

    method atacarSiPuede()
    method AtacarAgro()
    method sonidoHerida()
    method sonidoMuerte()

    // Persecucion -------------------------------------

    method moverse() {
        self.moverseHaciaAgro()
    }

    // Movimiento -------------------------------------

    method moverseHaciaAgro() {
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
        } else if (self.agro().position().x() < position.x() and self.agro().position().y() == position.y()) {
            self.moverse(izquierda)
        } else if (self.agro().position().x() > position.x() and self.agro().position().y() == position.y()) {
            self.moverse(derecha)
        } else if (self.agro().position().y() > position.y() and self.agro().position().x() == position.x()) {
            self.moverse(arriba)
        } else if (self.agro().position().y() < position.y() and self.agro().position().x() == position.x()) {
            self.moverse(abajo)
        }
    }

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
        managerZombie.zombies().remove(self)
        managerItems.spawnearMunicionEn(self.position())
    }
}

class ZombieComun inherits Zombie(vida = 100, dmg = 10, velocidad = 1000, image = "zombie-comun-abajo.png"){
    
    override method atacarSiPuede() {
        if (self.estaSobreAgro()) {
            self.AtacarAgro()
        }
    }

    // Ataque -----------------------------------------

    override method AtacarAgro() {
        self.agro().herir(dmg)
    }

    method estaSobreAgro() {
        return game.onSameCell(position, self.agro().position())
    }

    override method colisionPj() {}

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

    override method moverse() {
        if(!self.agroEstaCerca()) {
        self.moverseHaciaAgro()
        }
    }

    override method atacarSiPuede() {
        if (self.agroEstaCerca()) {
            self.AtacarAgro()
        }
    }

    override method AtacarAgro() {
        self.agro().herir(dmg)
    }

 
    method agroEstaCerca() {
        return self.posicionesAlRededor().any({posicion => posicion == self.agro().position()})
    }

    method posicionesAlRededor() {
        return #{arriba.siguientePosicion(self.position()), abajo.siguientePosicion(self.position()),
                    izquierda.siguientePosicion(self.position()), derecha.siguientePosicion(self.position()),
                        arriba.siguientePosicion(derecha.siguientePosicion(self.position())),
                            arriba.siguientePosicion(izquierda.siguientePosicion(self.position())),
                                abajo.siguientePosicion(derecha.siguientePosicion(self.position())),
                                    abajo.siguientePosicion(izquierda.siguientePosicion(self.position()))}
    }

    override method colisionPj() {}

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

    override method atacarSiPuede() {
        if(self.agroEstaCerca()) {
            self.AtacarAgro()
        }
    }

    override method AtacarAgro() {
        self.golpearSuelo()
    }

    method golpearSuelo() {
        // acá hace la animación primero y luego hace el daño...
    }

    override method moverse() {
        if(!self.agroEstaCerca()) {
        self.moverseHaciaAgro()
        }
    }

    method agroEstaCerca() {
        return self.posicionesAlRededor().any({posicion => posicion == self.agro().position()})
    }

    method posicionesAlRededor() {
        return #{arriba.siguientePosicion(self.position()), abajo.siguientePosicion(self.position()),
                    izquierda.siguientePosicion(self.position()), derecha.siguientePosicion(self.position()),
                        arriba.siguientePosicion(derecha.siguientePosicion(self.position())),
                            arriba.siguientePosicion(izquierda.siguientePosicion(self.position())),
                                abajo.siguientePosicion(derecha.siguientePosicion(self.position())),
                                    abajo.siguientePosicion(izquierda.siguientePosicion(self.position()))}
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

class ZombieThrower inherits Zombie(vida = 20, dmg = 30, velocidad = 1200, image = "zombie-comun-abajo.png"){
    
    // movimiento ------------------------------------

    override method moverse() {
        if(!self.agroEstaAlFrente() and !self.puedeBajar()) {
            self.moverse(arriba)
        } else if (!self.agroEstaAlFrente() and self.puedeBajar()){
            self.moverse(abajo)
        }
    }

    method agroEstaAlFrente() {
        return self.agro().position().y() == self.position().y()
    }

    method puedeBajar() { 
        return abajo.siguientePosicion(self.position()).y() >= 0
    }

    // ataque y colisión ------------------------------

    override method colisionPj() {}

    override method atacarSiPuede() {
        if(self.agroEstaAlFrente()) {
            self.AtacarAgro()
        }
    }

    override method AtacarAgro() {

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
        return "zombie-comun-"
    }
}