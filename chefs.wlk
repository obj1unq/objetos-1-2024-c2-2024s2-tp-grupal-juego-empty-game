import personaBase.*
import posiciones.*

import wollok.game.*

class Chef inherits Persona {
    var property bandeja = bandejaVacia

  method tengoBandejaVacia() {
    return bandeja.esVacio()
  }

  method llevoAlgo(){
    return not self.tengoBandejaVacia()
  }

   method interactuar() {
        self.validarMueble() 
        const mueble = ubicacion.muebleAqui(self.dondeApunta())
      
        mueble.usarse(self)
    }

    method validarMueble(){
      if(not ubicacion.hayMuebleAqui(self.dondeApunta())){
        self.error("no hay ningun mueble aqui para hacer lo que quiero hacer")
      }
    }

    method soltar(){
      bandeja = bandejaVacia 
    }

    method recibir(ingrediente) {
      bandeja = ingrediente
    }

    method procesar(){
     self.validarMueble()
     const mueble = ubicacion.muebleAqui(self.dondeApunta())

     mueble.procesarIngredientes()
    }

    method preguntarPedido() {
      ubicacion.clienteActual().anunciarPedido()
    }
    
}
