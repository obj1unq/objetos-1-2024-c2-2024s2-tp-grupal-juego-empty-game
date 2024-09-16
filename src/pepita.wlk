import wollok.game.*
import posiciones.*
import extras.*

object pepita {

	var property isMoving = true //flag
	var energia = 100
	var position = game.at(5,5);
	//lo ponemos como atributo porque tenemos que inicializarlo en una cierta celda!
	const cazador = silvestre
	
	method position() {
		return position
	}

	method image() {
		return "pepita" + self.estado() + ".png"
	}

	method estado() {
		return if (self.estaEnNido()) {
			return "-grande"
		} else if (self.estaAtrapada()) {
			return "-gris"
		} else {
			return ""
		}
	}

	method estaEnNido() {
		return position==game.at(7,8)
	}

	method estaAtrapada() {
		return position==cazador.position()
	}

	method mover(direccion) {
		position = direccion.siguiente(position)
	}

	method comer(comida) {
		energia = energia + comida.energiaQueOtorga()
	}

	method volar(kms) {
		energia = energia - 10 - kms 
	}
	
	method energia() {
		return energia
	}

}

