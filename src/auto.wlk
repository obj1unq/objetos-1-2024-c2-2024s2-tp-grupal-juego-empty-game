import wollok.game.*
import tablero.*
import cosas.*

object auto{
    var property position = game.at(0,0)
    var property image = "autoHaciaAbajo.png"
    const property objetosRecolectados = #{}

    method agarrarObjeto() {
      const objeto = game.uniqueCollider(self)
      objeto.objetoALaBarra()

    }

}