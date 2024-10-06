import wollok.game.*

object fondo {
  var escenario = 1
  
  method position() = game.at(0, 0)
  
  method image() = ("intro" + escenario) + ".png"
  
  method cambiar() {
    escenario = (escenario + 1) % 6
  }
  
}