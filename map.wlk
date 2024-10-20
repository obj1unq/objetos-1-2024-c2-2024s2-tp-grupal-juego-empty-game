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

    method agregarAliado(aliado){
     aliados.add(aliado)
    }

    method agregarEnemigo(enemigo){
        enemigos.add(enemigo)
    }

    method aliadosEn(position) {
        return aliados.find({pj => pj.position() == cabezal.position()})
    }

    method validarSeleccion(coordenadas) {
        if (not self.hayAliadosEn(coordenadas)){
            cabezal.error("No hay nada para seleccionar!")
        }
    }

    method hayAliadosEn(coordenadas) {
        return aliados.any({aliado => aliado.position() == coordenadas})
    }

    method hayEnemigosEn(coordenadas){
        return enemigos.any({enemigo => enemigo.position() == coordenadas})
    }

    method hayUnidadAca(posicion){
        return self.hayAliadosEn(posicion) and self.hayEnemigosEn(posicion)
    }
}