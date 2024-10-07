import wollok.game.*
import posiciones.*

class Proyectil {

    method mover(direccion) {
	    position = direccion.siguientePosicion(position)
	}

    var property image = null
    var property position = null
    method colisionPj() {} // por si las dudas -_-

}

class Bala inherits Proyectil() {

    method imagenEnNumDir(num,direccion) {
       return "bala-" + num.toString() + "-" + direccion.toString() + ".png"
    }

    method disparoHacia(direccion) {
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

     method disparoHacia(direccion) {
        self.image(self.imagenEnNumDir(2, direccion))
        game.schedule(50,{self.imagenEnNumDir(3, direccion)})
        game.schedule(50,{self.imagenEnNumDir(4, direccion)})
        self.mover(direccion)
        self.imagenEnNumDir(1, direccion)
    }
}