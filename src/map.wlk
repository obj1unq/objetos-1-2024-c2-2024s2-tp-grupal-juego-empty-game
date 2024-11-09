import cabezal.*
import wollok.game.*
import objetos.*
import characters.*


object fondo {
    var property position = game.origin()

    method image() {
        return "map.png"
      
    }
}

object mapa {
    const property aliados = #{}
    const property enemigos = #{}
    const property objetos = #{}

    method validarSiEstaDentro(posicion) {
        return if (not self.estaDentro(posicion)) {
             cabezal.error("No me puedo mover a esa posición ya que esta fuera de los limites!")
        }
    }

    method estaDentro(posicion) {
		return posicion.x().between(0, game.width() - 1) and posicion.y().between(0, game.height() - 1)
	}

    method validarSiHayAlgunPersonaje(posicion) {
        return if (self.hayUnidadAca(posicion)) {
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

    method aliadosEn(posicion) {
        return aliados.find({pj => pj.position() == posicion})
    }

    method enemigosEn(posicion) {
        return enemigos.find({pj => pj.position() == posicion})
    }

    method validarSeleccionAliada(posicion) {
        if (not self.hayAliadosEn(posicion)){
            cabezal.error("No hay nada para seleccionar!")
        }
    }

    method hayAliadosEn(posicion) {
        return aliados.any({aliado => aliado.position() == posicion})
    }

    method hayEnemigosEn(posicion){
        return enemigos.any({enemigo => enemigo.position() == posicion})
    }

    method hayUnidadAca(posicion){
        return self.hayAliadosEn(posicion) || self.hayEnemigosEn(posicion)
    }
    method validarSeleccionEnemiga(posicion) {
        if (not self.hayEnemigosEn(posicion)){
            cabezal.error("No hay nada para seleccionar!")
        }
    }

    method agregarObjeto(objeto) {
        objetos.add(objeto)
    }

    method eliminarObjeto(objeto) {
        objetos.remove(objeto)
    } 

    method objetoEn(posicion) {
        return objetos.find({o => o.position() == posicion})
    }

    method hayObjetoEn(posicion) {
        return objetos.any({o => o.position() == posicion})
    }
}