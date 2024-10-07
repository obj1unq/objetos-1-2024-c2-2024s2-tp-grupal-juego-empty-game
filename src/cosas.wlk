import wollok.game.*
import auto.*
import tablero.*
import randomizador.*


object termo {
  var property image = "termo_.png"
  var property position = randomizador.randomPosition()
  var property recogido = false

  method objetoALaBarra() {
    position = game.at(9,9)
    recogido = true
    
  }

  
}

object yerba {
  var property image = "yerba_.png"
  var property position = randomizador.randomPosition()
  var property recogido = false


  method objetoALaBarra() {
    position = game.at(8,9)
    recogido = true
    

  }
}

object bizcochitos {
  var property image = "bizcochitos_.png"
  var property position = randomizador.randomPosition()
  var property recogido = false


  method objetoALaBarra() {
    position = game.at(5,9)
    recogido = true
    

  }
}

object dispenser {
  var property image = "disp.png"
  var property position = randomizador.randomPosition()
  var property recogido = false


  method objetoALaBarra() {
    agua.position(game.at(6,9))
    game.addVisual(agua)
    recogido = true

    
    

  }
  
}

object agua {
  var property image = "agua_.png"
  var property position = null
  var property recogido = true

}

object manzanita {
  var property image = "manzana_.png"
  var property position = randomizador.randomPosition()
  var property recogido = false


    method objetoALaBarra() {
    position = game.at(4,9)
    recogido = true

  }
}

object mate {
  var property image = "mate.png"
  var property position = randomizador.randomPosition()
  var property recogido = false


  method objetoALaBarra() {
    position = game.at(7,9)
    recogido = true

  }


}