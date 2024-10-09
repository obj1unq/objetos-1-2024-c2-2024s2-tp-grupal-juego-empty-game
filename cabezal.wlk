import characters.*
//import characters.*
import wollok.game.*
import direcciones.*
import map.*



object cabezal {
    var property seleccionActualAliada = null
    var property position = game.origin()
    var property modoCabezal = cabezalNormal
    var property seleccionActualEnemiga = null

    method image(){
      return modoCabezal.image()
    }

    method mover(direccion) {
      const siguiente = direccion.siguiente(self.position()) 
      mapa.validarSiEstaDentro(siguiente)
      position = siguiente
    }


    method validarCabezalBatalla() {
      if (modoCabezal != cabezalBatalla){
        self.error("Solo se puede elegir enemigo en modo batalla!")
      }
    }

    method seleccionarEnemigo() {
      self.validarCabezalBatalla()
      mapa.validarSeleccionEnemiga(self.position())
      seleccionActualEnemiga = self.obtenerPjEnemigo(self.position())
    }
    
    method obtenerPjEnemigo(_position) {
      return mapa.enemigosEn(_position)
    }

    //por ahora solo selecciona un aliado para moverlo
    method seleccionarAliado() {
        mapa.validarSeleccionAliada(self.position())
        self.validarSiTengoAlgoSeleccionado()
        seleccionActualAliada = self.obtenerPjAliado(self.position())
        modoCabezal = cabezalSeleccion
    }

    method validarSiTengoAlgoSeleccionado() {
      return if (modoCabezal == cabezalSeleccion) {
        self.error("Ya tengo seleccionada una unidad")
      }
    }

    method obtenerPjAliado(_position) {
      return mapa.aliadosEn(_position)
    }

    method moverPj() {
      mapa.validarSiHayAlgunPersonaje(self.position())
      seleccionActualAliada.limpiarEnemigosAlAlcance()
      seleccionActualAliada.mover(self.position())
      seleccionActualAliada.definirEnemigosAlAlcance(self.position())
      seleccionActualAliada = null
      modoCabezal = cabezalNormal

    }


    method cancelar() {
      modoCabezal = cabezalNormal
      seleccionActualAliada = null
      seleccionActualEnemiga = null 
    }

    method modoBatalla() {
      self.verificarEnemigos()
      modoCabezal = cabezalBatalla
    }

    method verificarEnemigos() {
      if (seleccionActualAliada.enemigosAlAlcance().size() < 1) {
        self.error("No hay nadie para atacar!")
      }      
    }
  
}

object cabezalSeleccion {
  method image() {
        return "cabezal_seleccion.png"
    }  
}

object cabezalBatalla {
  method image() {
        return "cabezal_batalla.png"
    } 
}

object cabezalNormal {
  method image() {
        return "cabezal.png"
    } 
}



