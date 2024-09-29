import wollok.game.*
import personaje.*
import randomizer.*
import paleta.*

object listaDeObjetos {

    method position() {
		return game.at(15,15)
	}

	method image() { 
		return "listaDeObj" + self.estado() + "-32Bits.png"
	}

    method estado() {
        if(personaje.bolsa().size()==3) {
            return "3"
        } else if (personaje.bolsa().size()==2) {
            return "2"
        } else if (personaje.bolsa().size()==1) {
            return "1"
        } else {
            return "0"
        }
    }

    method text() {return personaje.armaActual()}
    method textColor() = paleta.rojo()

}

object dungeon {

    method validarDentro(posicion) {
        if (!self.estaDentro(posicion)) {
            self.error("Soy una pared asshole")
        }
    }

    method estaDentro(posicion) {
        return posicion.x().between(0, game.width() - 2) && posicion.y().between(0, game.height() - 2) 
    }
}
