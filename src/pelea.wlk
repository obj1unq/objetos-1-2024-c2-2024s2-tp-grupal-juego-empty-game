import wollok.game.*
import posiciones.*
import extras.*
import paleta.*
import enemigos.*
import personaje.*

object combate {
    var turno = 0
    var property enemigo = null
 //   var personajeLuchando = enemigo

    method cambiarTurno() {
        turno = (turno + 1) % 2
    }

    method luchar() {
        if(turno == 1) {
        //    personajeLuchando = enemigo
            enemigo.atacar()
    } else {
        //    personajeLuchando = personaje
            personaje.pelear(enemigo)
        }
    //self.validarMuerte()
    }

 /*   method validarMuerte() {
        personajeLuchando.morir()
    }
  */
}

object barraEstadoPeleas {

    var property enemigo = null
    var property jugador = personaje

    method text() = "Barra De Peleas"
    method textColor() = paleta.rojo()


    // aparece todo lo que tiene que mostrar la barra de estado
    method aparecer() {
            game.addVisual(self)
            game.addVisual(vidaPersonaje)
            game.addVisual(vidaEnemigo)
            game.addVisual(ataque)

            // el personaje ataca
            jugador.estaEnCombate(true)

            //se evalua si la pelea termino o no
        //    game.onTick(500, "evaluarPelea", { self.desaparecer() } )

    }

    // desaparece la barra y todo lo que muestra, evaluando si alguno de los dos, personaje o enemigo, murio
    method desaparecer() {

       if(jugador.vida() <= 0 || enemigo.vida() <= 0){

            jugador.estaEnCombate(false)

            game.removeTickEvent("evaluarPelea")
            game.removeVisual(self)
            game.removeVisual(vidaPersonaje)
            game.removeVisual(vidaEnemigo)
            game.removeVisual(ataque)
            enemigo.morir()
           // game.stop()
            
        }
    }


    method position() = game.at(7, personaje.position().y() - 3)


}

object vidaPersonaje{

    method text() = "Vida: " + personaje.vida().toString()
        method textColor() = paleta.rojo()

    method position() = barraEstadoPeleas.position().down(1).left(2)

}

object vidaEnemigo {

    method text() = "Enemigo Vida: " + barraEstadoPeleas.enemigo().vida().toString()
    method textColor() = paleta.rojo()

    method position() = vidaPersonaje.position().right(3)

}

object ataque{

    method position() = vidaPersonaje.position().down(1)
    method text() = personaje.armaActual()
    method textColor() = paleta.rojo()

}