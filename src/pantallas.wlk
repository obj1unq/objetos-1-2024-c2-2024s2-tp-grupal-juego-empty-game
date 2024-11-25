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

object finVictoria inherits Pantalla {

    method image() {
        return "pantallaVictoria.png"
    }
}

object finDerrota inherits Pantalla {

    method image() {
        return "pantallaDerrota.png"
    }
}