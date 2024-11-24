import turno.*
import wollok.game.*
import map.*
import characters.*
import cabezal.*
import direcciones.*
import edificios.*
import objetos.*
import colores.*

object cantidadTurnos {
  
    method position() {
        return game.at(18, 11)
    }

    method text() {
        return "       Turnos restantes: " + mapa.nivelActual().turnosDelNivel()
    }

    method textColor() {
      return paleta.blanco()
    }

}

object textoReservas {

    method position() {
        return game.at(18, 10)
    }

    method text() {
        return "     Oro: "  + castillo.oroEnReserva() + "      Piedra: " + castillo.piedrasEnReserva() + "      Huevos: " + castillo.huevosEnReserva()
    }

    method textColor() {
      return paleta.blanco()
    }
}

object pjActual {
    var property image = null

    method position() {
        return game.at(18, 7)
    }

    method actualizarImage(imagen) {
        image = imagen
    }

    method removerPjActual() {
        game.removeVisual(self)
    }
}

object statsPjActual {

    method position() {
        return game.at(18, 8)
    }

    method text() {
        if (cabezal.hayAliadoSeleccionado()) {
            return "          Ataque: " + cabezal.seleccionActualAliada().ataqueBase().toString() + 
            "    Defensa: " + cabezal.seleccionActualAliada().defensaBase().toString()
        } else {
            return null
        }
    }

    method textColor() {
      return paleta.blanco()
    }
}


object probabilidades {

    method position() {
        return game.at(18, 4)
    }

    method text() {
        return "                Probabilidad de victoria VS:"
    }

    method textColor() {
      return paleta.blanco()
    }
}
object probabilidadesDragonGolem {

    method position() {
        return game.at(18, 3)
    }

    method text() {
        if (cabezal.hayAliadoSeleccionado()) {
            return "              Dragon: " + (cabezal.seleccionActualAliada().ataqueBase() / (cabezal.seleccionActualAliada().ataqueBase() + 4 )).truncate(2) +
                    "               Golem: "  + (cabezal.seleccionActualAliada().ataqueBase() / (cabezal.seleccionActualAliada().ataqueBase() + 10 )).truncate(2)
        } else {
            return null
        }
    }

    method textColor() {
      return paleta.blanco()
    }
}

object probabilidadesComandSol {

    method position() {
        return game.at(18, 2)
    }

    method text() {
        if (cabezal.hayAliadoSeleccionado()) {
            return "                  Comandante: " + (cabezal.seleccionActualAliada().ataqueBase() / (cabezal.seleccionActualAliada().ataqueBase() + 5 )).truncate(2) +
                    "        Soldado: "  + (cabezal.seleccionActualAliada().ataqueBase() / (cabezal.seleccionActualAliada().ataqueBase() + 4 )).truncate(2)
        } else {
            return null
        }
    }

    method textColor() {
      return paleta.blanco()
    }
}

object probabilidadesArqMag {

    method position() {
        return game.at(18, 1)
    }

    method text() {
        if (cabezal.hayAliadoSeleccionado()) {
            return "              Mago: " + (cabezal.seleccionActualAliada().ataqueBase() / (cabezal.seleccionActualAliada().ataqueBase() + 2 )).truncate(2) +
                    "               Arquero: "  + (cabezal.seleccionActualAliada().ataqueBase() / (cabezal.seleccionActualAliada().ataqueBase() + 2 )).truncate(2)
        } else {
            return null
        }
    }

    method textColor() {
      return paleta.blanco()
    }
}