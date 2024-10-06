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

    method agregarAliado(aliado){
     aliados.add(aliado)
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
}