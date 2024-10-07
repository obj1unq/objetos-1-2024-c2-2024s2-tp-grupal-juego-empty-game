import wollok.game.*
import personajes.personaje.*

object managerItems {
    //const property drops = #{}

    method posicionRandom() {
        return (game.at(0.randomUpTo(game.width()-1), 0.randomUpTo(game.height()-1)))
    }

    method spawnearCura1() {
        const nuevaCura = new Cura1(position=self.posicionRandom())
        game.addVisual(nuevaCura)
        //drops.add(nuevaCura)
    }

    method spawnearOro1() {
        const oro1Nuevo = new Oro1(position=self.posicionRandom())
        game.addVisual(oro1Nuevo)
        //drops.add(oro1Nuevo)
    }
}

//---------------------------------Drops---------------------------------------

class Drop {
    var property position = null
    var property image = null

}

//---------------------------------Curas---------------------------------------
class Cura1 inherits Drop(image="vida.png"){
    const vidaDada = 20

    method colisionPj() {
        personaje.curarse(vidaDada)
        game.removeVisual(self)
        //managerItems.drops().remove(self)
    }
}
//---------------------------------Municion---------------------------------------
//volverlo clase y que haga algo

object balas {

    var property position = game.at(8,1)
    var property image = personaje.visualAmmo()

    method colisionPj() {
        personaje.recargar(6)
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

//---------------------------------Timer---------------------------------------

object timer {

    var segundos = 0
    var minutos  = 0

    method position() {
        return game.at(8, game.height() - 1 )
    }

    method text() {
        return minutos.toString() +":"+ segundos.toString()
    }

    method textColor() {
        return "FFFFFF"
    }

    method tick() {
        if(segundos < 60){
            segundos += 1
        }else{
            minutos += 1
            segundos = 0
            segundos += 1
        }

    }

    method colisionPj() {}

}
//----------------------------------------------HUD-----------------------------
object puntosDeVida {

    var property image =  "barravida-100.png"
    var property position = game.at(0, 16)

    method actualizar(){
        self.image("barravida-"+personaje.vida()+".png")
    }

    method colisionPj() {}
}

object cargador {
    var property position = game.at(6, 16)

    method text() {
        return personaje.municion().toString()
    }

    method colisionPj() {}

    method textColor() {
        return "90EE90"
    }
}
object oroObtenido {

    method position() {
        return game.at(12, game.height() - 1 )
    }

    method text() {
        return personaje.oro().toString()
    }

    method colisionPj() {}

    method textColor() {
        return "D4AF37"
    }
}