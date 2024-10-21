import wollok.game.*
import posiciones.*
import personajes.personaje.*
import sonidos.*

object managerZombie {
    const property zombies = #{}

    method spawnearZombieComun() {
        const zombieSpawneado = new ZombieComun(position = game.at(game.width() -2, game.height() -2), image = "zombie-comun-izquierda.png")
        zombies.add(zombieSpawneado)
        game.addVisual(zombieSpawneado)
        zombieSpawneado.persecucion()
    }
}

class Zombie {

    var property image
    var property position
    var property vida
    var property dmg
    var property velocidad

    method colisionPj() {}

    method agro() {
        return personaje
    }

    method impactoProyectil(danio) {
        vida -= danio
        self.fijarseMuerte()
        self.sonidoHerida()
    }

// Persecucion -------------------------------------

    method nombreEvento() {
        return "evento".identity()
    }

    method persecucion() {
        game.onTick(velocidad, self.nombreEvento(), {self.perseguirAPersonaje()})
    }

    method perseguirAPersonaje() {
        self.moverseHaciaAgro()
        self.atacarSiPuede() 
    }

    method atacarSiPuede() {
        if (self.estaSobreAgro()) {
            self.herirAgro()
        }
    }

    method estaSobreAgro() {
        return game.onSameCell(position, self.agro().position())
    }

    method moverseHaciaAgro() {
        self.moverseHaciaAgroEjeX()
        game.schedule(500, {self.moverseHaciaAgroEjeY()})
    }

// Movimiento -------------------------------------

    method moverseHaciaAgroEjeY() {
        if (self.agro().position().y() > position.y()) {
            self.mover(arriba)
        }
        else if (self.agro().position().y() < position.y()) {
            self.mover(abajo)
        }
    }

    method moverseHaciaAgroEjeX() {
        if (self.agro().position().x() > position.x()) {
            self.mover(derecha)
        }
        else if (self.agro().position().x() < position.x()) {
            self.mover(izquierda)
        }
    }

    method mover(direccion) {
	    position = direccion.siguientePosicion(self.position()) 
	}


// Ataque -----------------------------------------

    method herirAgro() {
        self.agro().herir(dmg)
    }

// Vida -------------------------------------------

    method fijarseMuerte() {
        if (vida <= 0) {
            self.sonidoMuerte()
            game.removeVisual(self)
            game.removeTickEvent(self.nombreEvento())
            managerZombie.zombies().remove(self)
        }
    }

// Sonido -------------------------------------------

    method sonidoHerida()

    method sonidoMuerte()
}

class ZombieComun inherits Zombie(vida = 100, dmg = 10, velocidad = 1000){

    override method moverseHaciaAgroEjeY() {
        super()
        if (self.agro().position().y() > position.y()) {
            self.image("zombie-comun-arriba.png")
        }
        else if (self.agro().position().y() < position.y()) {
            self.image("zombie-comun-abajo.png")
        }
    }

    override method moverseHaciaAgroEjeX() {
        super()
        if (self.agro().position().x() > position.x()) {
            self.image("zombie-comun-derecha.png")
        }
        else if (self.agro().position().x() < position.x()) {
            self.image("zombie-comun-izquierda.png")
        }
    }

    override method sonidoHerida(){
        game.sound("zombie-1.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-2.mp3").play()
    }
}


class Perro inherits Zombie(vida = 50, dmg = 10,  velocidad = 500){

    override method moverseHaciaAgroEjeY() {
        if (self.agro().position().y() > position.y()) {
            self.mover(arriba) 
            self.image("zombie-comun-arriba.png")
        }
        else if (self.agro().position().y() < position.y()) {
            self.mover(abajo)
            self.image("zombie-comun-abajo.png")
        }
    }

    override method moverseHaciaAgroEjeX() {
        if (self.agro().position().x() > position.x()) {
            self.mover(derecha)
            self.image("zombie-comun-derecha.png")
        }
        else if (self.agro().position().x() < position.x()) {
            self.mover(izquierda)
            self.image("zombie-comun-izquierda.png")
        }
    }

}