import wollok.game.*
import auto.*
import tablero.*
import randomizador.*
import barraSuperior.*


class Cosas {
  var property image 
  var property position 
  var property recogido = false 

  method cosaALaBarra() 

  method solida() {
		return false
	}

}

class Termo inherits Cosas(image = "termo_.png"){


  override method cosaALaBarra() {
    position = frameTermo.position()
    recogido = true
    
  }

  
}

class Yerba inherits Cosas(image = "yerba_.png") {
  
  override method cosaALaBarra() {
    position = frameYerba.position()
    recogido = true
    

  }
}

class Dispenser inherits Cosas (image = "disp.png") {

  override method cosaALaBarra() {
    agua.position(frameAgua.position())
    game.addVisual(agua)
    recogido = true
  }
  
}

object agua {
  var property image = "agua_.png"
  var property position = null

}


class Mate inherits Cosas(image = "mate.png") {

   override method cosaALaBarra() {
    position = frameMate.position()
    recogido = true

  }

}

//Bonusssssss

class Manzanita inherits Cosas(image = "manzana_.png") {
    

    override method cosaALaBarra() {
    position = game.at(5,9) 
    recogido = true

  }
}

class Bizcochitos inherits Cosas(image = "bizcochitos_.png") {


  override method cosaALaBarra() {
    position = game.at(4,9)
    recogido = true
    
  }
}


class Palmeritas inherits Cosas(image = "palmeritas_.png") {

  override method cosaALaBarra() {
    position = game.at(3,9)
    recogido = true
  }

}

