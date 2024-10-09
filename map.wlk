import cabezal.*
import wollok.game.*


object fondo {
    var property position = game.origin()

    method image() {
        return "map.png"
      
    }
}

object mapa {
    const property aliados = #{}
    const property enemigos = #{}

    method validarSiEstaDentro(posicion) {
        return if (not self.estaDentro(posicion)) {
             cabezal.error("No me puedo mover a esa posición ya que esta fuera de los limites!")
        }
    }

    method estaDentro(posicion) {
		return posicion.x().between(0, game.width() - 1) and posicion.y().between(0, game.height() - 1)
	}

    method validarSiHayAlgunPersonaje(posicion) {
        return if (self.hayAliadosEn(posicion) or self.hayEnemigosEn(posicion)) {
            cabezal.error("No puedo mover la seleccion actual a esa posición ya que hay otro personaje")
        }
    }

    method quitarEnemigo(enemigo) {
        enemigos.remove(enemigo)
    }

    method agregarAliado(aliado){
     aliados.add(aliado)
    }

    method agregarEnemigo(enemigo){
        enemigos.add(enemigo)
    }

    method aliadosEn(position) {
        return aliados.find({pj => pj.position() == cabezal.position()})
    }

    method enemigosEn(position) {
        return enemigos.find({pj => pj.position() == cabezal.position()})
    }

    method validarSeleccionAliada(coordenadas) {
        if (not self.hayAliadosEn(coordenadas)){
            cabezal.error("No hay nada para seleccionar!")
        }
    }

    method hayAliadosEn(coordenadas) {
        return aliados.any({aliado => aliado.position() == coordenadas})
    }

    method validarSeleccionEnemiga(coordenadas) {
        if (not self.hayEnemigosEn(coordenadas)){
            cabezal.error("No hay nada para seleccionar!")
        }
    }

    method hayEnemigosEn(coordenadas) {
        return enemigos.any({enemigo => enemigo.position() == coordenadas})
    }
}