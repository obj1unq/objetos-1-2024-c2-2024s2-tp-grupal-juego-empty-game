import wollok.game.*

object mago {
    var property position = game.origin()

    method mover(_pos) {
        position = _pos
    }

    method image() {
        return "mage.png"
    }
  
}