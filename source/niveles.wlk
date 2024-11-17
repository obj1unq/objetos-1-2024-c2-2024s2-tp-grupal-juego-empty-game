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


niveles de mapas de referencia pepita

object mapa {

    const tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,n,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,m,_,p,_,_,_,_,_,_,_],     
     [_,_,_,m,_,_,_,_,_,_,_,_,_],     
     [_,_,_,m,m,m,m,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,s,_,_,_,_,_,_,_]         
    ].reverse()

    method dibujar() {
        game.height(tablero.size())
        game.width(tablero.get(0).size())

        (0..game.width() - 1).forEach({ x =>
            (0..game.height() -1).forEach({y =>
                tablero.get(y).get(x).dibujarEn(game.at(x,y))
            })
        })
        game.addVisual(pepita) //Lo pongo aca por el eje z


    }
}