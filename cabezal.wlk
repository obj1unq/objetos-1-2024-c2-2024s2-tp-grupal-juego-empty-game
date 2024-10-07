//import characters.*
import wollok.game.*
import direcciones.*
import map.*



object cabezal {
    var property seleccionActualAliada = null
    var property position = game.origin()
    var property modoCabezal = cabezalSeleccion
    var property seleccionActualEnemiga = null

    method image(){
      return modoCabezal.image()
    }

    method mover(direccion) {
        position = direccion.siguiente(self.position())
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
        seleccionActualAliada = self.obtenerPjAliado(self.position())
    }

    method obtenerPjAliado(_position) {
      return mapa.aliadosEn(_position)
    }

    method moverPj() {
      seleccionActualAliada.mover(self.position())
      seleccionActualAliada.definirEnemigosAlAlcance(self.position())
      seleccionActualAliada = null

    }


    method cancelar() {
      modoCabezal = cabezalSeleccion 
    }

    method modoBatalla() {
      modoCabezal = cabezalBatalla
    }
  
}

object cabezalSeleccion {
  method image() {
        return "cabezal.png"
    }  
}

object cabezalBatalla {
  method image() {
        return "cabezal_batalla.png"
    } 
}



