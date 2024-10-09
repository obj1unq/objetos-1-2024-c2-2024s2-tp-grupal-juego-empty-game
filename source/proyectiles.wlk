import wollok.game.*
import posiciones.*


class Proyectil {

    method mover(direccion) {
	    position = direccion.siguientePosicion(position)
	}

    method nuevoViaje(dir) { 
        game.onTick(40, self.nombreEvento() , {self.disparoHacia(dir)})
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

class Bala inherits Proyectil() {

    
    method imagenEnNumDir(num,direccion) {
       return "bala-" + num.toString() + "-" + direccion.toString() + ".png"
    }

    override method disparoHacia(direccion) {
        self.validarViajeBala(direccion)
        self.animacionBala(direccion)
    }

    method validarViajeBala(direccion) {
        if (self.siguenColisiones(direccion)) {
            self.image("bala-impacto-" + direccion.toString() + ".png")
            game.removeTickEvent("viajeDeProyectil" + self.identity())
            game.schedule(70,{game.removeVisual(self)})
        }
    }

    method animacionBala(direccion) {
        self.image(self.imagenEnNumDir(2, direccion))
        game.schedule(20,{self.imagenEnNumDir(3, direccion)})
        game.schedule(20,{self.imagenEnNumDir(4, direccion)})
        self.mover(direccion)
        self.imagenEnNumDir(1, direccion)
    }

}

class BolaDeFuego inherits Proyectil() {

    method imagenEnNumDir(num,direccion) {
        return "bola-" + num.toString() + "-" + direccion.toString() + ".png"
    }

     override method disparoHacia(direccion) {
        self.validarViajeBola(direccion)
        self.animacionBola(direccion)
    }

    method validarViajeBola(direccion) {
        if (self.siguenColisiones(direccion)) {
            self.image("bola-impacto-" + direccion.toString() + ".png")
            game.removeTickEvent("viajeDeProyectil".identity())
            game.schedule(70,{game.removeVisual(self)})
        }
    }

    method animacionBola(direccion) {
        self.image(self.imagenEnNumDir(2, direccion))
        game.schedule(50,{self.imagenEnNumDir(3, direccion)})
        game.schedule(50,{self.imagenEnNumDir(4, direccion)})
        self.mover(direccion)
        self.imagenEnNumDir(1, direccion)
    }
}