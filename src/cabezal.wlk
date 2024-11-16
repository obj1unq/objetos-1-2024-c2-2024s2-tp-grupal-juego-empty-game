import characters.*
import wollok.game.*
import direcciones.*
import map.*
import objetos.*
import edificios.*



object cabezal {
  var property seleccionActualAliada = null
  var property position = game.origin()
  var property modoCabezal = cabezalNormal
  var property seleccionActualEnemiga = null

  method inicializar() {
    position = game.origin()
    modoCabezal = cabezalNormal
    game.addVisual(self)
  }

  method image(){
    return modoCabezal.image()
  }


  method mover(direccion) {
    const siguiente = direccion.siguiente(position) 
    self.validarMoverCabezal(siguiente)
    position = siguiente
  }

  method validarMoverCabezal(posicion) {
    mapa.validarSiEstaDentro(posicion)
    mapa.validarSiHayObjetoSolido(posicion)
  }


  method cancelar() {
    modoCabezal = cabezalNormal
    seleccionActualAliada = null
    seleccionActualEnemiga = null 
  }

  method accionar() {
    modoCabezal.accionar()
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

  method obtenerPjAliado() {
    return mapa.aliadosEn(position)
  }

  method obtenerPjEnemigo() {
    return mapa.enemigosEn(position)
  }

  method obtenerObjetoEn() {
    return mapa.objetoEn(position)
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
    cabezal.seleccionActualAliada().enemigosAlAlcance()
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
    mapa.validarSeleccionAliada(cabezal.position()) // 
    cabezal.setAliado(cabezal.obtenerPjAliado())
    cabezal.setModo(cabezalAtaque)
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
    cabezal.setAliado(cabezal.obtenerPjAliado())
    cabezal.setModo(cabezalSeleccion)
  }

  
}

object cabezalAtaque {
  
  method image() {
    return "cabezal_ataque.png"
  }

  method accionar() {
    mapa.validarSeleccionEnemiga(cabezal.position())
    cabezal.setEnemigo(cabezal.obtenerPjEnemigo())
    cabezal.seleccionActualAliada().atacar(cabezal.seleccionActualEnemiga())
  }


}

