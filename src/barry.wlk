import wollok.game.*
import posiciones.*
import extras.*
import menu.*

object barry {
	var property position = game.at(1,5)
	var property imagenActual = "barrynormal.png"
	
	method image() {
		return imagenActual
	}

	method mover(direccion) {
        var nuevaPosicion = direccion.siguiente(self.position()) 
        tablero.validarDentro(nuevaPosicion) // Validar el movimiento
        self.position(nuevaPosicion) // Actualizar la posición 
    }

	method volar() {
	  self.mover(arriba)
	  imagenActual = "barryvolando.png"
	}

    method caer() {
	  self.mover(abajo)
	  imagenActual = "barrynormal.png"
	}
	
}