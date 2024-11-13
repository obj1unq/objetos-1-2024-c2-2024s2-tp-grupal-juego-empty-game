import hud.*
import wollok.game.*
import personajes.personaje.*

object managerItems {
    const property drops = #{}

    method quitarItem(item) {
        drops.remove(item)
    }

    method revisarPorItems(pos) {
        const itemAhi = drops.filter({d => d.position() == pos})
        itemAhi.forEach({d => d.colisionPj()})
    }

    method posicionRandom() {
        return (game.at(0.randomUpTo(game.width() - 1).round(), 0.randomUpTo(game.height() - 2).round()))
    }

    method spawnearCura(numero) {
        const nuevaCura = managerCuras.cura(numero, self.posicionRandom())
        game.addVisual(nuevaCura)
        drops.add(nuevaCura)
    }

    method spawnearOro(numero) {
        const oroNuevo = managerMonedas.monedas(numero, self.posicionRandom())
        game.addVisual(oroNuevo)
        drops.add(oroNuevo)
    }

    method spawnearMunicionRandom() {
        const nuevaMunicion = new Balas(position = self.posicionRandom())
        game.addVisual(nuevaMunicion)
        drops.add(nuevaMunicion)
    }

    method spawnearMunicionEn(posicion) {
        const nuevaMunicion = new Balas(position = posicion)
        game.addVisual(nuevaMunicion)
        drops.add(nuevaMunicion)
    }
}

//---------------------------------Drops---------------------------------------

class Drop {
    var property position
    var property image

    method traspasable() {
        return true
    }
}

object managerCuras {
    const vida = [20, 40, 80]

    method cura(numero, position) {
        return new Cura(image = personaje.visualHealth(numero)
                , vidaDada = self.vida(numero), position = position)
    }

    method vida(numero) {
        return vida.get(numero - 1)
    }
}

object managerMonedas {
    const oro = [10, 30, 50]
    
    method monedas(numero, position) {
        return new Oro(image = "oro" + numero + ".png",
                valor = self.oro(numero), position = position)
    }

    method oro(numero) {
        return oro.get(numero - 1)
    }
}

//---------------------------------Curas---------------------------------------
class Cura inherits Drop {
    const vidaDada

    method colisionPj() {
        personaje.curarse(vidaDada)
        game.removeVisual(self)
        managerItems.quitarItem(self)
    }
}

//---------------------------------Monedas---------------------------------------

class Oro inherits Drop()  {
    const valor

    method colisionPj() {
        personaje.obtenerOro(valor)
        game.removeVisual(self)
        managerItems.quitarItem(self)
    }
}

//---------------------------------Municion---------------------------------------

class Balas inherits Drop(image = personaje.visualAmmo()){

    method colisionPj() {
        cargador.recargar(6)
        game.removeVisual(self)
        managerItems.quitarItem(self)
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

