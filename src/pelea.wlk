import wollok.game.*
import posiciones.*
import extras.*
import paleta.*
import enemigos.*
import personaje.*


object barraEstadoPeleas {

    var property enemigo = null
    var property jugador = personaje

    method text() = "Barra De Peleas"



    method aparecer() {
            game.addVisual(self)
            game.addVisual(vidaPersonaje)
            game.addVisual(vidaEnemigo)
            game.addVisual(ataque)
            game.onTick(500, "evaluarPelea", { self.desaparecer() } )
    }

    method desaparecer() {
        if(jugador.vida() == 0 || enemigo.vida() == 0){
            game.removeTickEvent("evaluarPelea")
            game.removeVisual(self)
            game.removeVisual(vidaPersonaje)
            game.removeVisual(vidaEnemigo)
            game.removeVisual(ataque)
        }
    }

    method position() = game.at(5,2)


}

object vidaPersonaje{

    method text() = "Vida: " + personaje.vida()

    method position() = barraEstadoPeleas.position().down(1).left(2)

}

object vidaEnemigo {

    method text() = "Enemigo Vida: " + barraEstadoPeleas.enemigo().vida()

    method position() = vidaPersonaje.position().right(3)

}

object ataque{

}