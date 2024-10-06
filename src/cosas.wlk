import wollok.game.*
import auto.*
import tablero.*
import randomizador.*


object termo {
  var property image = "termo.png"
  var property position = randomizador.randomPosition()

  method objetoALaBarra() {
    position = game.at(9,9)
  }
}

object yerba {
  var property image = "yerba.png"
  var property position = randomizador.randomPosition()

  method objetoALaBarra() {
    position = game.at(8,9)
  }
}

object bizcochitos {
  var property image = "bizcochitos.png"
  var property position = randomizador.randomPosition()

  method objetoALaBarra() {
    position = game.at(7,9)
  }
}

object dispenser {
  var property image = "disp.png"
  var property position = randomizador.randomPosition()

  method objetoALaBarra() {
    agua.position(game.at(6,9))
    game.addVisual(agua)
    
    
  }
  
}

object agua {
  var property image = "agua.png"
  var property position = null
}

