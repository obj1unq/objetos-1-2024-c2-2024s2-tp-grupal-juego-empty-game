import cabezal.*
import wollok.game.*
import map.*
import direcciones.*

class Comandante {
    //stats provisionales
    const property ataqueBase = null 
    const property defensaBase = 3
    const property vidaBase = 15
    var property vidaActual = vidaBase
    const property team = null
    const property inventario = null
    var property position = null
    const property enemigosAlAlcance =#{}

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
        cabezal.modoBatalla()
    }

    method atacar(enemigo) {
        enemigo.recibirDano()
        enemigo.morirSiCorresponde()
    }


    method recibirDano() {
        vidaActual -= (cabezal.seleccionActualAliada().ataqueBase() - cabezal.seleccionActualEnemiga().defensaBase())
    }

    method morirSiCorresponde() {
        if (vidaActual < 1){
            self.morir()
        }
    }

    method morir() {
        mapa.quitarEnemigo(self)
        self.quitarEnemigoAlAlcance(self)
        game.removeVisual(self)
        cabezal.modoCabezal(cabezalNormal)
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