import characters.*
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
    position = direccion.siguiente(self.position())
  }

  method cancelar() {
    modoCabezal = cabezalNormal
    seleccionActualAliada = null
    seleccionActualEnemiga = null 
  }

  method accionar() {
    modoCabezal.accionar()
  }

  method modoBatalla() {
    modoCabezal = cabezalBatalla
  }

  method limpiarSelecAliada() {
    return null
  }

  method setAliado(aliado) {
    seleccionActualAliada = aliado
  }

  method setModo(modo) {
    modoCabezal = modo
  }

  method setEnemigo(enemigo) {
    seleccionActualEnemiga = enemigo    
  }
  
}

object cabezalSeleccion {
  
  method image() {
    return "cabezal_seleccion.png"
  }

  //MOVER
  method accionar() {
    cabezal.seleccionActualAliada().verificarMovimiento()
    cabezal.seleccionActualAliada().mover(cabezal.position())
    cabezal.seleccionActualAliada().definirEnemigosAlAlcance(cabezal.position())
    cabezal.setAliado(null)
    cabezal.setModo(cabezalNormal)
  }

  method cancelar() {
    cabezal.setModo(cabezalNormal)
    cabezal.setAliado(null)
    cabezal.setEnemigo(null) 
  }
}

object cabezalBatalla {
  method image() {
      return "cabezal_batalla.png"
  }

  //SELECCIONAR ENEMIGO
  method accionar() {
    //self.validarCabezalBatalla()
    mapa.validarSeleccionEnemiga(cabezal.position())
    cabezal.setEnemigo(self.obtenerPjEnemigo(cabezal.position()))
  }

  method obtenerPjEnemigo(_position) {
    return mapa.enemigosEn(_position)
  }

  method verificarEnemigos() {
    if (cabezal.seleccionActualAliada.enemigosAlAlcance().size() < 1) {
      self.error("No hay nadie para atacar!")
    }      
  }
}

object cabezalNormal {
  method image() {
    return "cabezal.png"
  }

  //SELECCIONAR
  method accionar() {
    mapa.validarSeleccionAliada(cabezal.position())
    cabezal.setAliado(self.obtenerPjAliado(cabezal.position()))
    cabezal.setModo(cabezalSeleccion)
  }

  method obtenerPjAliado(_position) {
    return mapa.aliadosEn(_position)
  }
}



