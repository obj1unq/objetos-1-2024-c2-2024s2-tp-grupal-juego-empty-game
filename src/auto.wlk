import wollok.game.*
import tablero.*
import cosas.*
import posiciones.*

object auto{
    var property position = game.at(0,0)
    var property image = "autoHaciaArriba.png"

    method mover(direccion){
        const nuevaDireccion = direccion.siguiente(position)
        tablero.validarMovimiento(nuevaDireccion)

        position = nuevaDireccion
        image = direccion.imagen()


    }

    

}