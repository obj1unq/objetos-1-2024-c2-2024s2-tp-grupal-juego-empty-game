import wollok.game.*
import posiciones.*
import extras.*
import paleta.*
import enemigos.*
import armas.*
import randomizer.*
import pelea.*
import mapa.*

object personaje {
	var  position = game.at(7,2)
    var property salud = 300
	var cantVidas = 3
	const property bolsa = []
	var estaEnCombate = false
	var property armaActual = mano //porque empieza con bolsa vacía

	method position() {
		return position
	}

	method image() { 
		return "personaje" + self.imagenSegunEstado() + "-32Bits.png"
	}

	method imagenSegunEstado() {
		if(self.estaSinArma()) {
			return ""
		} else {
			return self.armaActual().imagenParaPersonaje()
		}
	}

	method estaSinArma() {
		return bolsa.size()==0
	}

	method cantVidas() {
		return cantVidas
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

	//MOVIMIENTO

	method mover(direccion) {
		self.validarMover(direccion)
		position = direccion.siguiente(position)
		dungeon.accionEnemigos()
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

	//COMBATE/PELEA
    var property enemigoCombatiendo = null //el enemigo con quien está en combate
	var esTurno = false //si es su turno en un combate

    method estaEnCombate(condicion){
        estaEnCombate = condicion
    }

    method atacarPre() {
        esTurno = true
    }

	method atacar() {
        self.validarCombate() // para que no le pegue a x enemigo cuando no esta peleando
		enemigoCombatiendo.recibirDanho(armaActual.danho()) 
		armaActual.realizarActualizacionDeArmas()
        esTurno = false //Indica que ya pasó turno. Sirve para que no pueda atacar al enemigo cuando no es su turno
		combate.cambiarTurnoA(enemigoCombatiendo)   //como ya terminó el turno del pj, se cambia el turno al enemigo
	}

	method actualizarArmaActual() { //esto se ejecuta solamente cuando se descarta el arma actual
		if(bolsa.size()>1) {
			armaActual = bolsa.get(1) //pone la 2da de la bolsa como el arma actual (la 1ra es la que se va a descartar)
		} else {
			armaActual = mano
		}
	}

    method validarCombate() {
        if(!estaEnCombate && !esTurno){
            self.error("No puedo atacar ahora")
        }
    }

	method recibirDanho(cantidad) {
		salud -= cantidad
	}
	
	method morir() {
		self.perderVida() // pierde una vida
		self.validarVida() // valida si está muerto (no tiene más vidas)
		position = game.at(2,2) 
        salud = 300
	}

	method perderVida() { //se pierde una vida cuando la salud del pj llega a 0
	  cantVidas -= 1
	}

	method validarVida() {
	  if (cantVidas <= 0){
		//position = game.at(27, 19) //si muere lo manda arriba a la izq 
		//salud = 0
		//self.error("Perdi!")
		gestorDeFondo.image("fondoFin.png")
		mapa.limpiar()
		game.stop()
	  }
	}

	method aumentarSalud(saludSumada) {
		salud += saludSumada
	}

}

//ESTADOS

/* el profe dijo que no estaba tan piola hacer objs estados si solo los vamos a usar para retornar el string para el image
object sinArma {

	method imagenParaPersonaje() {
		return ""
	}

}

object conArma {
	method imagenParaPersonaje() {
		return personaje.armaActual().imagenParaPersonaje()
	}

}
*/


