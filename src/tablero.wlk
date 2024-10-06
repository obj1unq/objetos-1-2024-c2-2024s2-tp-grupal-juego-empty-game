import wollok.game.*
import auto.*
import cosas.*
import reloj.*

object tablero {
  
  method validarMovimiento(position) {
    
    if (not self.estaDentroDeLosLimites(position)){
        self.error("No puede salir el limite del tablero") //para que no aparezca la burbuja en la visual
    }
  }

  method estaDentroDeLosLimites(position) {
    
    return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 2)
  }
}
