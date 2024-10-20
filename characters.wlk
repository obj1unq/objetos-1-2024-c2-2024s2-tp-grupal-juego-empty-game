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
    const property equipo = null
    const property inventario = #{}

    var property position = null
    const property enemigosAlAlcance = #{}

    var property fueMovido = false
    var property atacoEsteTurno = false

}

class Comandante inherits Personaje {

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
        enemigosAlAlcance.addAll(self.definirEnemigoHacia(arriba.siguiente(posicion))) 
        enemigosAlAlcance.addAll(self.definirEnemigoHacia(abajo.siguiente(posicion)))
        enemigosAlAlcance.addAll(self.definirEnemigoHacia(izquierda.siguiente(posicion)))
        enemigosAlAlcance.addAll(self.definirEnemigoHacia(derecha.siguiente(posicion)))    
    }

    method definirEnemigoHacia(posicion){
        return mapa.enemigos().filter({enemigo => enemigo.position()== posicion})
    }

    method batallar(){
        // mi ataque - defensa enemiga -> daño al enemigo
        // el ataque enemigo - mi defensa -> daño hacia mi
        // rango vs melee no hay trade
    }

    method image(){
        return "comandante-" + team.estado() + ".png"
    }

       method mover(_pos) {
        position = _pos
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