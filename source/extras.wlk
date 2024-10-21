import hud.*
import wollok.game.*
import personajes.personaje.*

object managerItems {
    //const property drops = #{}

    method posicionRandom() {
        return (game.at(0.randomUpTo(game.width() - 1), 0.randomUpTo(game.height() - 2)))
    }

    method spawnearCura1() {
        const nuevaCura1 = new Cura1(position=self.posicionRandom())
        const nuevaCura2 = new Cura2(position=self.posicionRandom())
        const nuevaCura3 = new Cura3(position=self.posicionRandom())
        game.addVisual(nuevaCura1)
        game.addVisual(nuevaCura2)
        game.addVisual(nuevaCura3)
        //drops.add(nuevaCura)
    }

    method spawnearOro1() {
        const oro1Nuevo = new Oro1(position=self.posicionRandom())
        game.addVisual(oro1Nuevo)
        //drops.add(oro1Nuevo)
    }

    method spawnearMunicion() {
        const nuevaMunicion = new Balas(position=self.posicionRandom())
        game.addVisual(nuevaMunicion)
        //drops.add(oro1Nuevo)
    }
}

//---------------------------------Drops---------------------------------------

class Drop {
    var property position = null
    var property image = null

}

//---------------------------------Curas---------------------------------------
class Cura1 inherits Drop(image = personaje.visualHealth(1)){
    const vidaDada = 20

    method colisionPj() {
        personaje.curarse(vidaDada)
        game.removeVisual(self)
        //managerItems.drops().remove(self)
    }
}

class Cura2 inherits Drop(image = personaje.visualHealth(2)){
    const vidaDada = 40

    method colisionPj() {
        personaje.curarse(vidaDada)
        game.removeVisual(self)
        //managerItems.drops().remove(self)
    }
}

class Cura3 inherits Drop(image = personaje.visualHealth(3)){
    const vidaDada = 80

    method colisionPj() {
        personaje.curarse(vidaDada)
        game.removeVisual(self)
        //managerItems.drops().remove(self)
    }
}
//---------------------------------Municion---------------------------------------

//object balas {
class Balas inherits Drop(image=personaje.visualAmmo()){
    //var property position = game.at(8,1)
    //var property image = personaje.visualAmmo()

    method colisionPj() {
        cargador.recargar(6)
        game.removeVisual(self)
    }
}

//---------------------------------Monedas---------------------------------------

class Oro1 inherits Drop(image="oro1.png")  {
    const valor = 10

    method colisionPj() {
        personaje.obtenerOro(valor)
        game.removeVisual(self)
        //managerItems.drops().remove(self)
    }
}

class Oro2 inherits Drop(image="oro2.png") {
    const valor = 30

    method colisionPj() {
        personaje.obtenerOro(valor)
        game.removeVisual(self)
        //managerItems.drops().remove(self)
    }  
}

class Oro3 inherits Drop(image="oro3.png") {
    const valor = 50

    method colisionPj() {
        personaje.obtenerOro(valor)
        game.removeVisual(self)
        //managerItems.drops().remove(self)
    }
}

//---------------------------------Colisiones---------------------------------------

object muro  {

    var property position = game.at(8,8)
    var property image = "madera.png"

}

object municionActual {

    method position() {return game.at(6, game.height() - 1 )}

    method text() {return cargador.municion().toString()}

    method colisionPj() {}

    method textColor() {return "FFFFFF"}

}