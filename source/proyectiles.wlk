import wollok.game.*
import posiciones.*
import enemigos.*


class Proyectil {

    var property danio
    var property image
    var property position

    method mover(direccion) {
	    position = direccion.siguientePosicion(position)
	}

    method nombreEvento() {
        return "evento" + self.identity()
    }

    method disparoHacia(direccion)

    method sigueOHayZombie(direccion) {
        const zombiesHacia = managerZombie.zombies().filter({zombie => self.sigueOEsta(direccion, zombie)}) // reotcasr
        return (not (zombiesHacia.isEmpty()))
    }

    method sigueOEsta(direccion, zombie) {
        return zombie.position() == direccion.siguientePosicion(position) or zombie.position() == position
    }

    method colisionPj() {} // por si las dudas -_-

    method impacto(dir) {
        game.removeTickEvent(self.nombreEvento())
        game.schedule(100,{game.removeVisual(self)})
    }

    method validarViajeProyectil(direccion) {
        if (self.sigueOHayZombie(direccion)) {
            const zombiesHacia = managerZombie.zombies().filter({zombie => self.sigueOEsta(direccion, zombie)})
            zombiesHacia.forEach({zombie => zombie.impactoProyectil(danio)})
            self.impacto(direccion)
        }
        else if (not(tablero.estaDentro(direccion.siguientePosicion(position)))) {
            self.impacto(direccion)
        }
    }

}

class Bala inherits Proyectil(danio=10) {


    method nuevoViaje(dir) { 
        game.onTick(60, self.nombreEvento() , {self.disparoHacia(dir)})
    }

    method imagenEnNumDir(num,direccion) {
       return "bala-" + num.toString() + "-" + direccion.toString() + ".png"
    }

    override method disparoHacia(direccion) {
        self.validarViajeProyectil(direccion)
        self.animacionBala(direccion)
    }

    method animacionBala(direccion) {
        self.image(self.imagenEnNumDir(2, direccion))
        game.schedule(20,{self.imagenEnNumDir(3, direccion)})
        game.schedule(20,{self.imagenEnNumDir(4, direccion)})
        self.mover(direccion)
        self.imagenEnNumDir(1, direccion)
    }

    override method impacto(dir) {
        self.image("bala-impacto-" + dir.toString() + ".png")
        super(dir)
    }
}

class BolaDeFuego inherits Proyectil(danio=20) {

    method nuevoViaje(dir) { 
        game.onTick(150, self.nombreEvento() , {self.disparoHacia(dir)})
    }

    method imagenEnNumDir(num,direccion) {
        return "bola-" + num.toString() + "-" + direccion.toString() + ".png"
    }

    override method disparoHacia(direccion) {
        self.validarViajeProyectil(direccion)
        self.animacionBola(direccion)
    }

    method animacionBola(direccion) {
        self.image(self.imagenEnNumDir(2, direccion))
        game.schedule(50,{self.imagenEnNumDir(3, direccion)})
        game.schedule(50,{self.imagenEnNumDir(4, direccion)})
        self.mover(direccion)
        self.imagenEnNumDir(1, direccion)
    }

    override method impacto(dir) {
        self.image("bola-impacto-" + dir.toString() + ".png")
        super(dir)
    } 
}