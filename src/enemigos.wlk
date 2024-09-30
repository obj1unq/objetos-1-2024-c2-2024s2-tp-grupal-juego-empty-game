import wollok.game.*
import personaje.*
import posiciones.*
import pelea.*


/*Tenemos que hacerlo clase pero yo no entendí :)*/
object enemigo1 {
    var  position = game.at(14,12)
    const objetivoADestruir = personaje
    var property vida = 100
	
	method position() {
		return position
	}

    method distanciaEnEjeX() {
        return (objetivoADestruir.position().x() - position.x())
    }

    method distanciaEnEjeY() {
        return (objetivoADestruir.position().y() - position.y())
    }

    method mover() { 
        if (self.distanciaEnEjeX().abs() > self.distanciaEnEjeY().abs()) {
            if(self.distanciaEnEjeX() > 0) {
                position = derecha.siguiente(position)
            } else {
                position = izquierda.siguiente(position)
            }
        } else if (self.distanciaEnEjeY().abs() > self.distanciaEnEjeX().abs()) {
            if(self.distanciaEnEjeY() > 0) {
                position = arriba.siguiente(position)
            } else {
                position = abajo.siguiente(position)
            }
        }
    }

	method image() { //image() se calcula a cada frame al igual que position(), si no entendí mal
		return "enemigo1" + self.estado() + "-32Bits.png"
	}

	method estado() {
		return ""
	}

    // COMBATE/PELEA

    /*  - La posicion del enemigo es una celda a la derecha del personaje cuando empieza el combate.
        - Se le manda el enemigo a la barra de estado para saber con que enemigo esta peleando.
        - Aparece la barra de estado.
    */
    method combate() {
        position = position.right(1)
        game.say(self, "Ah! Pelea!")
        barraEstadoPeleas.enemigo(self)
        barraEstadoPeleas.aparecer()
        combate.enemigo(self)
        combate.darseTurnoDelCombate()
    }

    method atacar() {
        objetivoADestruir.recibirDanho(13) //FUTURO: Hacer las habilidades del enemigo y hacerlo clase
        combate.cambiarTurno()
        combate.darseTurnoDelCombate()
    }

    method recibirDanho(cantidad){
        vida = vida - cantidad
    }

    method morir() {
        /*Este método despues se va cambiar por un removeVisual o algo asi, esta así ahora para testear porque solo tenemos un enemigo.*/
      position = game.at(7,4)
      vida = 100
    }

   // method validarMuerte() {
//		
//	}


    // cuando el pj colsiona con el enemigo, este incia el combate
    method colisiono(personaje){
        self.combate()
    }

}