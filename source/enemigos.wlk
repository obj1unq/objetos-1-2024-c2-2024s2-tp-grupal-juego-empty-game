import wollok.game.*
import posiciones.*
import personajes.personaje.*

object managerZombie {
    const property zombies = #{}

    method spawnearZombieComun() {
        const zombieSpawneado = new ZombieComun(position = game.at(game.width() -1, game.height() -1), image = "zombie-comun-izquierda.png")
        zombies.add(zombieSpawneado)
        game.addVisual(zombieSpawneado)
        zombieSpawneado.persecucion()
    }

}

class Zombie {

    var property agro = personaje
    var property image = null
    var property position = null
    var property vida = null
    var property dmg = null
    var property tipo = Zombie

    method colisionPj() {}

    method impactoProyectil(danio) {
        vida -= danio
        self.fijarseMuerte()
    }

// Persecucion -------------------------------------

    method nombreEvento() {return "persecucion".identity()}

    method persecucion() {
        game.onTick(1000, self.nombreEvento(), {self.perseguirAPersonaje()})
    }

    method perseguirAPersonaje() {
        self.moverseHaciaAgro()
        self.atacarSiPuede() 
    }

    method atacarSiPuede() {
        if (self.estaSobreAgro()) {self.herirAgro()}
    }

    method estaSobreAgro() {
        return game.onSameCell(position, agro.position())
    }

    method moverseHaciaAgro() {
        self.moverseHaciaAgroEjeX()
        game.schedule(500,{self.moverseHaciaAgroEjeY()})
    }

// Movimiento -------------------------------------

    method moverseHaciaAgroEjeY() {
        if (agro.position().y() > position.y()) {self.mover(arriba)}
        else if (agro.position().y() < position.y()) {self.mover(abajo)}
    }

    method moverseHaciaAgroEjeX() {
        if (agro.position().x() > position.x()) {self.mover(derecha)}
        else if (agro.position().x() < position.x()) {self.mover(izquierda)}
    }

    method mover(direccion) {
	    position = direccion.siguientePosicion(self.position()) 
	}


// Ataque -----------------------------------------

    method herirAgro() {
        agro.herir(dmg)
    }

// Vida -------------------------------------------

    method fijarseMuerte() {
        if (vida <= 0) {
            game.removeVisual(self)
            game.removeTickEvent(self.nombreEvento())
        }
    }

}

class ZombieComun inherits Zombie(vida = 100, dmg = 10){

    override method moverseHaciaAgroEjeY() {
        if (agro.position().y() > position.y()) {
            self.mover(arriba) 
            self.image("zombie-comun-arriba.png")
        }
        else if (agro.position().y() < position.y()) {
            self.mover(abajo)
            self.image("zombie-comun-abajo.png")
        }
    }

    override method moverseHaciaAgroEjeX() {
        if (agro.position().x() > position.x()) {
            self.mover(derecha)
            self.image("zombie-comun-derecha.png")
        }
        else if (agro.position().x() < position.x()) {
            self.mover(izquierda)
            self.image("zombie-comun-izquierda.png")
        }
    }
}