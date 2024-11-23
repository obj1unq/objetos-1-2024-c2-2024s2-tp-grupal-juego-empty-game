import wollok.game.*
import posiciones.*
import extras.*
import paleta.*
import enemigos.*
import personaje.*
import mapa.*

object combate {

    var property entidadAtacando = null //aquel que tiene el turno para atacar
    const heroe = personaje
    var property hayCombate = false

    method iniciarCombate(enemigo){
        self.entidadAtacando(enemigo)
        heroe.enemigoCombatiendo(entidadAtacando)
        hayCombate = true
        barraEstadoPeleas.enemigo(entidadAtacando)
        barraEstadoPeleas.aparecerJuntoADemasBarras()
        self.entidadAtacaOTerminaCombate() //empieza el combate atacando el enemigo
    }

    method cambiarTurnoA(entidad){
        entidadAtacando = entidad
        self.entidadAtacaOTerminaCombate() //acá se valida si el que ahora tiene el turno sigue con vida y, si es así, este realiza su ataque
    }

    method entidadAtacaOTerminaCombate() {  
        if(entidadAtacando.salud() <= 0) {
            hayCombate = false
            entidadAtacando.morir()
            game.schedule(805, {barraEstadoPeleas.desaparecerJuntoADemasBarras()}) //con schedule para que se puedan ver animaciones d muerte
        } else {
            entidadAtacando.atacarPre()
        }   
    }

}

object barraEstadoPeleas {

    var property enemigo = null
    var property heroe = personaje
    var property image = "barraBase.png"

    method position() = game.at(heroe.position().x() - 2, heroe.position().y() + 4)

    // aparece todo lo que tiene que mostrar la barra de estado
    method aparecerJuntoADemasBarras() {
            game.addVisual(self)
            game.addVisual(saludPersonaje)
            game.addVisual(saludEnemigo)
            game.addVisual(durabilidad)
            //game.addVisual(turnoTest)
    }

    // desaparece la barra y todo lo que muestra tras darse la muerte del personaje o el enemigo
    method desaparecerJuntoADemasBarras() {
        image = "barraBase.png"
        game.removeVisual(self)
        game.removeVisual(saludPersonaje)
        game.removeVisual(saludEnemigo)
        game.removeVisual(durabilidad)
        //game.removeVisual(turnoTest)
    }

}

object saludPersonaje {

    method text() = " ❤️ PJ: " + barraEstadoPeleas.heroe().salud().toString()
    method textColor() = paleta.rojo()

    method position() = saludEnemigo.position().right(2)

}

object saludEnemigo {

    method text() = "❤️ EN: " + barraEstadoPeleas.enemigo().salud().toString() + "   "
    method textColor() = paleta.azul()

    method position() =  barraEstadoPeleas.position().down(1).right(1)

}

object durabilidad {

    method position() = barraEstadoPeleas.position().down(2).right(2)
    method text() = "❤️ " + personaje.armaActual().emojiParaInfoCombate() + ": " + personaje.armaActual().durabilidad().toString()
    method textColor() = paleta.rojo()

}

object turnoTest {
    method position() = game.at(1,16)//ataque.position().right(5)
    method text() = "Turno De: " + combate.entidadAtacando()
    method textColor() = paleta.rojo()
}
