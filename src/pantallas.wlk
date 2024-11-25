import wollok.game.*
import map.*

class Pantalla {

    var property position = game.at(0,0)

}


object inicio inherits Pantalla {

    method image() {
        return "pantallaInicioNew.png"
    }
}

object fin inherits Pantalla {

    method image() {
        return "pantallaFinal.png"
    }
}