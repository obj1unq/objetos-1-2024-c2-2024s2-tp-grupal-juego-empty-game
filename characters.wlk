import wollok.game.*
import map.*
import direcciones.*

class Comandante {
    //stats provisionales
    const ataqueBase = 10 
    const defensaBase = 10
    const vidaBase = 10
    const property team = null
    const property inventario = null
    var property position = null
    const property enemigosAlAlcance =#{}

    method definirEnemigosAlAlcance(posicion){
        enemigosAlAlcance.addAll(self.definirEnemigoHacia(game.at(posicion.x(), posicion.y()+1))) 
        enemigosAlAlcance.addAll(self.definirEnemigoHacia(game.at(posicion.x(), posicion.y()-1))) 
        enemigosAlAlcance.addAll(self.definirEnemigoHacia(game.at(posicion.x()+1, posicion.y()))) 
        enemigosAlAlcance.addAll(self.definirEnemigoHacia(game.at(posicion.x()-1, posicion.y())))      
    }

    method definirEnemigoHacia(posicion){
        return mapa.enemigos().filter({enemigo => enemigo.position()== posicion})
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