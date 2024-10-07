import wollok.game.*
import tablero.*
import cosas.*
import posiciones.*
import reloj.*

object auto{
    var property position = game.at(0,0)
    var property image = "autoHaciaArriba.png"

    method mover(direccion){
        const nuevaDireccion = direccion.siguiente(position)
        tablero.validarMovimiento(nuevaDireccion)
        reloj.validarContinuarJuego()

        position = nuevaDireccion
        image = direccion.imagen()


    }


    method agarrarObjeto() {
      const objeto = game.uniqueCollider(self)
      objeto.objetoALaBarra()
    }

}
