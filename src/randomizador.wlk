import wollok.game.*

object randomizador{
  var property posicion = null
  
  method randomPosition() {
    return game.at(1.randomUpTo(9).roundUp(), 1.randomUpTo(8).roundUp())
  } 

}