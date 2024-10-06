//import characters.*
import wollok.game.*
import direcciones.*
import map.*



object cabezal {
    var property seleccionActual = null
    var property position = game.origin()
    var cantidadDeMovimientos = 0

    method mover(direccion) {
        //const siguiente = direccion.siguiente(self.position())
        position = direccion.siguiente(self.position())
    }

    method image() {
        return "cabezal.png"
    }

    //por ahora solo selecciona un aliado para moverlo
    method seleccionar() {
        mapa.validarSeleccion(self.position())
        seleccionActual = self.obtenerPj(self.position())
    }

    method obtenerPj(_position) {
      return mapa.aliadosEn(_position)

    }

    method moverPj() {
      seleccionActual.mover(self.position())
      
      seleccionActual.definirEnemigosAlAlcance(self.position())

      seleccionActual = null

    }


    method cancelar() {
      seleccionActual = null 
    }

  
}

object seleccionado {
  
}

object deseleccionado {
  
}