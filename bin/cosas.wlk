import wollok.game.*
import auto.*
import tablero.*
import randomizador.*
import barraSuperior.*


class Cosa {
  var property image 
  var property position 
  var property recogido = false 

  method frame()

  method cosaALaBarra(){
    position = self.frame().position()
    recogido = true
    
  } 

  method solida() {
		return false
	}

  method esAgarrable(){
    return true
  }

}

class Termo inherits Cosa(image = "termo_.png"){

  override method frame(){
    return frameTermo
  }

  // override method cosaALaBarra() {

  // }

  
}

class Yerba inherits Cosa(image = "yerba_.png") {
  
  // override method cosaALaBarra() {
  //   position = frameYerba.position()
  //   recogido = true
  // }

    override method frame(){
    return frameYerba
  }
}

class Dispenser inherits Cosa (image = "disp.png") {

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


class Mate inherits Cosa(image = "mate.png") {

  //  override method cosaALaBarra() {
  //   position = frameMate.position()
  //   recogido = true

  // }

    override method frame(){
    return frameMate
  }

}

//Bonusssssss

class Manzanita inherits Cosa(image = "manzana_.png") {
    

  //   override method cosaALaBarra() {
  //   position = game.at(5,9) 
  //   recogido = true

  // }
}

class Bizcochitos inherits Cosa(image = "bizcochitos_.png") {


  // override method cosaALaBarra() {
  //   position = game.at(4,9)
  //   recogido = true
    
  // }
}


class Palmeritas inherits Cosa(image = "palmeritas_.png") {

  // override method cosaALaBarra() {
  //   position = game.at(3,9)
  //   recogido = true
  // }

}

