import wollok.game.*
import auto.*
import cosas.*

object reloj {

    var property segundos = 120

    method position() {
        return game.at(0, game.height() - 1 )
    }

    method text() {
        return segundos.toString()
    }

    method textColor() {
        return "FFFF00FF"
    }

    method tick() {
        segundos = (segundos - 1) % 1000
    }
    method solida() {
		return false
	}

}