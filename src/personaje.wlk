import wollok.game.*
import posiciones.*
import extras.*
import paleta.*
import enemigos.*
import armas.*
import randomizer.*
import pelea.*


object personaje {

    var property vida = 100
	var estaEnCombate = false
	const property bolsa = []
	var  position = game.at(7,2);
	var property armaActual = mano //bolsa.head()

	method position() {
		return position
	}

	method image() { //image() se calcula a cada frame al igual que position(), si no entendí mal
		return "personaje" + self.estado() + "-32Bits.png"
	}

	method estado() {
		if(self.estaSinArma()) {
			return ""
		} else {
			return armaActual.imagenParaPersonaje()
		}
	}

	method estaSinArma() {
		return bolsa.size()==0
	}

	/// ARMA    
    method equiparArma(armaNueva){
    	bolsa.add(armaNueva) // mete el arma en la bolsa (atrás)
        self.armaActual(bolsa.head()) // Su arma actual es la primera de la bolsa (si no tenía ninguna, será la nueva)
		game.removeVisual(armaNueva)
    }
    
    method armaActual(arma){
        armaActual = arma
    }

	//acciones con teclas

	method mover(direccion) {
		self.validarMover(direccion)
		position = direccion.siguiente(position)
		enemigo1.mover()
	}   

	method validarMover(posicion) {
		const siguiente = posicion.siguiente(self.position())
		dungeon.validarDentro(siguiente)
		self.validarMoverPelea()
	}

	method validarMoverPelea() {
		if (estaEnCombate) {
			self.error(null)
		}
	}

    method estaEnCombate(condicion){
        estaEnCombate = condicion
    }

	method llevarACaboAtaque(enemigo) { //de este modo, solo se puede ejecutar atacar estando dentro de una pelea
		keyboard.up().onPressDo({self.atacar(enemigo)})
	}

	method atacar(enemigo) {
		enemigo.recibirDanho(armaActual.danho()) //ya no hace falta preguntar si está en combate, porq atacar solo se ejecuta cuando hay uno
		armaActual.chequearDurabilidad()	
		combate.cambiarTurno()
		combate.luchar()
	}

	method recibirDanho(cantidad) {
		vida -= cantidad
	}

/*	method morir() {
		
	}

	method validarMuerte() {

	}
*/
}


