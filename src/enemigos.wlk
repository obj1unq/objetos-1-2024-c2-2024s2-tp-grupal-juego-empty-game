import wollok.game.*
import personaje.*
import posiciones.*
import pelea.*

object enemigo1 {
    var  position = game.at(3,9); 
	const property esArma = false
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

    //con esta implementación, se ejecuta solamente JUSTO después de que se mueva personaje
    //análisis del caso de este tablero puntual:
    //como empiezan pj en (5,5) y enem en (0,0), cuando pj va arriba o derecha (no se "auto-recorta" distancia), enem le sigue, va en esa
    //misma dirección y quedan igual
    //cuando pj va izquierda o abajo (se "auto-recorta" distancia), enem le recorta por el eje por donde no regaló distancia
    //ej: si se va a la izquierda y regala una posición de eje x, enem va hacia arriba y le recorta posición de eje y.
    //notese que, nuevamente, la distancia en ambos ejes es equivalente
    //es por esto que nunca, luego de un movimiento de pj, que es cuando se ejecuta este método, se dará que 
    //la distancia eje X == la distancia eje Y, por lo que no se tiene en cuenta ese imposible caso
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
		return "enemigo1" + self.estado() + ".png"
	}

	method estado() {
		return ""
	}


    // combate /pelea
    /*  - La posicion del enemigo es una celda a la derecha del personaje cuando empeiza en combate.
        - se le manda el enemigo a la barra de estado para saber con que enemigo esta pelean.
        - aparece la barra de estado.
    */
    method combate(){
        position = position.right(1)
        game.say(self, "Ah! Pelea!")
        barraEstadoPeleas.enemigo(self)
        barraEstadoPeleas.aparecer()
        
    }

    method recibirDanho(cantidad){
        vida = vida - cantidad
    }

    method morir() {
        position = game.at(7,4)
        vida = 100
    }

}