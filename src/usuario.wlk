import wollok.game.*
import posiciones.*

object usuario {
    var property position = game.at(3,3)
    var property image = "avatar.png"

    method mover(direccion) {
        const siguiente = direccion.siguiente(position)
        limite.validarLimites(siguiente)
        position = siguiente
    }
}