import wollok.game.*
import posiciones.*


class Proyectil {

    var property danio = null

    method mover(direccion) {
	    position = direccion.siguientePosicion(position)
	}

    method nombreEvento() {return "viajeDeProyectil" + self.identity()}

    method disparoHacia(dir) {}

    method siguenColisiones(dir) {
        return (not(game.getObjectsIn(dir.siguientePosicion(position)).isEmpty()))
    }

    var property image = null
    var property position = null
    method colisionPj() {} // por si las dudas -_-

}

class Bala inherits Proyectil(danio=10) {


    method nuevoViaje(dir) { 
        game.onTick(60, self.nombreEvento() , {self.disparoHacia(dir)})
    }

    method imagenEnNumDir(num,direccion) {
       return "bala-" + num.toString() + "-" + direccion.toString() + ".png"
    }

    override method disparoHacia(direccion) {
        self.validarViajeBala(direccion)
        self.animacionBala(direccion)
    }

    method validarViajeBala(direccion) {
        if (self.siguenColisiones(direccion)) {
            const hitbox = game.getObjectsIn(direccion.siguientePosicion(position))
            hitbox.forEach({colision => colision.impactoProyectil(danio)})
            self.balaImpacto(direccion)
        }
        else if (not(tablero.estaDentro(direccion.siguientePosicion(position)))) {
            self.balaImpacto(direccion)
        }
    }

    method animacionBala(direccion) {
        self.image(self.imagenEnNumDir(2, direccion))
        game.schedule(20,{self.imagenEnNumDir(3, direccion)})
        game.schedule(20,{self.imagenEnNumDir(4, direccion)})
        self.mover(direccion)
        self.imagenEnNumDir(1, direccion)
    }

    method balaImpacto(dir) {
        self.image("bala-impacto-" + dir.toString() + ".png")
        game.removeTickEvent(self.nombreEvento())
        game.schedule(100,{game.removeVisual(self)})
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
        self.validarViajeBola(direccion)
        self.animacionBola(direccion)
    }

    method validarViajeBola(direccion) {
        if (self.siguenColisiones(direccion)) {
            const hitbox = game.getObjectsIn(direccion.siguientePosicion(position))
            hitbox.forEach({colision => colision.impactoProyectil(danio)})
            self.bolaImpacto(direccion)
        }
        else if (not(tablero.estaDentro(direccion.siguientePosicion(position)))) {
            self.bolaImpacto(direccion)
        }
    }

    method animacionBola(direccion) {
        self.image(self.imagenEnNumDir(2, direccion))
        game.schedule(50,{self.imagenEnNumDir(3, direccion)})
        game.schedule(50,{self.imagenEnNumDir(4, direccion)})
        self.mover(direccion)
        self.imagenEnNumDir(1, direccion)
    }

    method bolaImpacto(dir) {
        self.image("bola-impacto-" + dir.toString() + ".png")
        game.removeTickEvent(self.nombreEvento())
        game.schedule(100,{game.removeVisual(self)})
    } 
}