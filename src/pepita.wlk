import wollok.game.*
import posiciones.*
import extras.*

object pepita {

	const property bolsa = [new Arma(tipo = espada, durabilidad = 100), new Arma(tipo = arcoYFlecha, durabilidad = 120), 
						   new Arma(tipo = cetroMagico, durabilidad = 60)]
	//de momento, la idea es que las armas sean NO sean ÚNICAS, por lo que el pj puede tener 2 de la misma. por tanto, usamos una lista
	//en vez de un conjunto.
	//para esta idea de armas no únicas usamos la clase Arma
	//su máximo, por ahora, es de 3
	var property isMoving = true //flag
	var energia = 100
	var position = game.at(5,5); //lo ponemos como atributo porque tenemos que inicializarlo en una cierta celda pero tmb va cambiando
								 //si fuera estático podríamos tener simplemente un metodo posición que devuelva esa pos estática
	const cazador = silvestre
	
	method position() {
		return position
	}

	method image() { //image() se calcula a cada frame al igual que position(), si no entendí mal
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

	//se ataca con la primer arma que se tiene en la bolsa, que viene a ser el arma actual. El ataque, de momento, no causa ningún efecto
	//además de bajar la durabilidad del arma.
	method atacar() { 
		if (!bolsa.isEmpty()) { //para que no se ejecute bolsa.head() si está vacía la lista, lo cual daría error (queremos que simplemente no pase nada)
			bolsa.head().atacar()
			if(bolsa.head().durabilidad()<=0) {
				bolsa.remove(bolsa.head()) //dps del ataque, se revisa si el arma quedó con durabilidad menor a 0. ifso, se rompe y descarta
		
			}
		}
	}

}

