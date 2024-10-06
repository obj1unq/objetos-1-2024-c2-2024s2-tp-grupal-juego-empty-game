import wollok.game.*
import auto.*
import cosas.*
import reloj.*

object tablero {
  
  method validarMovimiento(position) {
    
    if (not self.estaDentroDeLosLimites(position)){
        auto.error("No podes pasar te vas fuera de los limites!!")
    }
  }

  method estaDentroDeLosLimites(position) {
    
    return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 2)
  }
}
