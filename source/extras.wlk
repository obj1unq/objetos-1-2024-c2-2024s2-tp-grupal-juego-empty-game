import hud.*
import wollok.game.*
import personajes.personaje.*

//---------------------------------Drops---------------------------------------

class Drop {
    var property position
    var property image

    method traspasable() {
        return true
    }
}

//---------------------------------Curas---------------------------------------
class Cura inherits Drop {
    const vidaDada

    method colisionPj() {
        personaje.curarse(vidaDada)
        game.removeVisual(self)
        //managerItems.drops().remove(self)
    }
}

//---------------------------------Monedas---------------------------------------

class Oro inherits Drop()  {
    const valor

    method colisionPj() {
        personaje.obtenerOro(valor)
        game.removeVisual(self)
        //managerItems.drops().remove(self)
    }
}

//---------------------------------Municion---------------------------------------

class Balas inherits Drop(image = personaje.visualAmmo()){

    method colisionPj() {
        cargador.recargar(6)
        game.removeVisual(self)
    }
}


//---------------------------------Colisiones---------------------------------------

object muro  {

    var property position = game.at(8,8)
    var property image = "madera.png"

    method traspasable() {
        return false
    }
}

object municionActual {

    method position() {return game.at(6, game.height() - 1 )}

    method text() {return cargador.municion().toString()}

    method colisionPj() {}

    method textColor() {return "FFFFFF"}

}

