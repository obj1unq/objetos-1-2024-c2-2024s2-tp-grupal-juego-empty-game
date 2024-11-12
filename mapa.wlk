import restaurante.*
import chefs.*
import comestibles.*
import objetosCocina.*
import posiciones.*
import objetosParaTests.*
import wollok.game.*


object dimension {

    const ancho = 10
    const largo = 10


    method tamanioMapa() {
    game.height(largo)
    game.width(ancho)
    }
}

object teclas{

    method movimiento(){

    keyboard.up().onPressDo({remy.mover(arriba)})
    keyboard.down().onPressDo({remy.mover(abajo)})
    keyboard.right().onPressDo({remy.mover(derecha)})
    keyboard.left().onPressDo({remy.mover(izquierda)})
    }

    method accion(){
    keyboard.q().onPressDo({remy.interactuar()})
    }
}

object imagenes {

    method ingredientesImg(){
        game.addVisual(estacionTomate)
        //game.addVisual(new Tomate(position = game.at(4,0)))
        game.addVisual(new Masa(position = game.at(6,0)))
        game.addVisual(new Queso(position = game.at(8,0)))
        game.addVisual(new Aceituna(position = game.at(9,5)))
        game.addVisual(new Hongo(position = game.at(9,7)))
        game.addVisual(new Huevo(position = game.at(9,3)))
        game.addVisual(new Atun(position = game.at(9,1)))
    }

    method hornoImg(){
        game.addVisual(new Horno(position = game.at(3,9)))
        game.addVisual(new Horno(position = game.at(5,9)))
    }

    method chefImg(){
        game.addVisual(remy)
    }
}
    
