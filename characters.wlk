import wollok.game.*
import map.*
import direcciones.*

class Personaje {
    //stats
    const property ataqueBase = null
    const property defensaBase = null
    const property vidaBase = null
    var property vidaActual = vidaBase

    //team 
    const property team = null
    const property inventario = #{}

    var property position = null
    const property enemigosAlAlcance = #{}

    var property fueMovido = false
    var property atacoEsteTurno = false

    method efectoMover() {
        fueMovido = true
    }

        method quitarEnemigoAlAlcance(enemigo) {
        enemigosAlAlcance.remove(enemigo)
    }

    method limpiarEnemigosAlAlcance() {
        enemigosAlAlcance.clear()
    }

    method definirEnemigosAlAlcance(posicion){
        enemigosAlAlcance.addAll(self.definirEnemigoEn(arriba.siguiente(posicion))) 
        enemigosAlAlcance.addAll(self.definirEnemigoEn(abajo.siguiente(posicion)))
        enemigosAlAlcance.addAll(self.definirEnemigoEn(izquierda.siguiente(posicion)))
        enemigosAlAlcance.addAll(self.definirEnemigoEn(derecha.siguiente(posicion)))    
    }

    method definirEnemigoEn(posicion){
        return mapa.enemigos().filter({enemigo => enemigo.position()== posicion})
    }


           method mover(_pos) {
        position = _pos
    }

}

class Comandante inherits Personaje {


   method image(){
        return "comandante-" + team.estado() + ".png"
    }


}


object mago {
    var property position = game.at(1,1)

    method mover(_pos) {
        position = _pos
    }

    method image() {
        return "mage.png"
    }
  
}

object comandante {

}

object soldado {

}

object arquero {

}

object golem {

}

object dragon {

}

object aliado {
    method estado(){
        return "aliado"
    }
}

object enemigo {
    method estado(){
        return "enemigo"
    }
}