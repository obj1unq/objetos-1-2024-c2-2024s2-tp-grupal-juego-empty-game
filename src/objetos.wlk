import wollok.game.*
import personaje.*

//BOTON
class Boton {
    const property position
    var property color = rojo

    method image() {
        return "boton_" + color.toString() + ".png"
    }
}

object rojo {}

object verde {}

//CAJA
class Caja {
    var property position
    var property estado = normal

    method image() {
        return "caja_" + estado.toString() + ".png"
    }
}

object normal {}

object bloqueada {}

// MURO
class Muro {
    var property position
    const property image = "muro.png"
}