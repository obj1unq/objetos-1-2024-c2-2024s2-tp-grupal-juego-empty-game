import wollok.game.*
import map.*
import direcciones.*

class Comandante {
    //stats provisionales
    const ataqueBase = 10 
    const defensaBase = 3
    const vidaBase = 15
    const property team = null
    const property inventario = null
    var property position = null
    const property enemigosAlAlcance =#{}

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