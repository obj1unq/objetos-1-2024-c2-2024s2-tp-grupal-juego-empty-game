import wollok.game.*
import enemigos.*
import juego.*
import personajes.personaje.*

object nivelManager {
    var property nivelActual = 1
    var property enemigosDerrotados = 0
    var enemigosPorNivel = 10

        method incrementarEnemigos() {
        enemigosDerrotados += 1
        self.revisarNivel()
    }

    method revisarNivel() {
        if (enemigosDerrotados >= enemigosPorNivel) {
            enemigosDerrotados = 0
            nivelActual += 1
            self.cambiarNivel()
            enemigosPorNivel += 5
        }
    }
    
        method cambiarNivel() {
        game.sound("nivel-up.mp3").play()
        // Cambiar configuración del juego según el nivel
        juego.configurarNivel(nivelActual)
    }
}