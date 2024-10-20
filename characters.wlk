import wollok.game.*
import map.*
import direcciones.*

class Personaje {
    //stats
    const property ataqueBase
    const property defensaBase
    const property vidaBase
    var property vidaActual = vidaBase

    var property team

    var property position = game.at(0,0) //me pedia inicializarlo, pero spawnean en el castillo.
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

class Comandante inherits Personaje(ataqueBase = 7, defensaBase = 2, vidaBase = 100) {

    const property inventario = #{}


    method image(){
        return "comandante-" + team.estado() + ".png"
    }


}


class Mago inherits Personaje(ataqueBase = 2, defensaBase = 1, vidaBase = 100) {


    method image() {
        return "mage-" + team.estado()+".png"
    }
  
}


class Soldado inherits Personaje(ataqueBase = 4, defensaBase = 2, vidaBase = 100) {

    method image(){
        return "soldado-" + team.estado() +".png"
    }
}

class Arquero inherits Personaje (ataqueBase = 5, defensaBase = 1, vidaBase = 100) {
    
    method image(){
        return "arquero-" + team.estado() +".png"
    }
}

class Golem inherits Personaje(ataqueBase = 5, defensaBase = 5, vidaBase = 100) {
    
    method image(){
        return "golem-" + team.estado() + ".png"
    }
}

class Dragon inherits Personaje (ataqueBase = 10, defensaBase = 3, vidaBase = 100) {

    method image(){
        return "dragon-"+ team.estado() + ".png"
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