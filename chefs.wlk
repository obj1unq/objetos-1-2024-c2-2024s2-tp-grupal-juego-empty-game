import posiciones.*
import restaurante.*
import objetosParaTests.*

import wollok.game.*

//falta como hacer que lo que este en bandeja la imagen aparezca en frente del chef, sino lo que se podría hacer que es más trabajo creo era lo de una imagen para cada cosa que puede sostener, eso también haría que ver como implementarlo

class Persona {
    var property orientacion = abajo //en donde está mirando
    var property position = game.at(0,0) //la posicion es placeholder por ahora
    var image = null //por default le ponemos una imagen a cada cliente y a cada chef
    //const property ubicacion = restaurante preguntar si conviene más guardarlo en variable o tener referencia global
    var property nombre = null //para los clientes sería tipo cliente

    method mover(direccion) {
      orientacion = direccion //es importante que primero cambie a donde mira y después se mueva o no
      const nuevaPosition = direccion.moverse(self.position())

      self.validarMoverseHacia(nuevaPosition)
      self.nuevaImagen()
      position = nuevaPosition
	}

  method validarMoverseHacia(_position){
    if(restaurante.hayMuebleAqui(_position)){
      self.error("no me puedo mover ahí")
    }
  }

  method image(_image){
    image = _image
  }

  method nuevaImagen(){
    image = orientacion.imagen(nombre)
    // hay que hacer los place holder del chef con bandeja
  }

    method dondeEstoyApuntando() { 
    return orientacion.moverse(self.position())
  }


}

class Chef inherits Persona {
    var property bandeja = bandejaVacia

     method tengoBandejaVacia() {
    return bandeja.esVacio()
  }

   method interactuar() {
        const mueble = restaurante.muebleAqui(self.dondeEstoyApuntando())
        mueble.usarse(self)
    }

    method soltar(){
      bandeja = bandejaVacia //la bandeja representa el no tener nada, es un objeto vacio
    }

    method recibir(ingrediente) {
      bandeja = ingrediente
    }

//probar:
  method preguntarPedido() {
    self.validarPreguntarPedido()
    restaurante.clienteAqui(self.dondeEstoyApuntando()).decirPedido()
  }

  method validarPreguntarPedido(){
    if(not restaurante.hayClienteAqui(self.dondeEstoyApuntando())){
      self.error("no hay ningun cliente aqui")
    }
  }
}

object bandejaVacia {
  // method esBandejaVacia(){ queda feo, esta mal preguntarle al objeto si es objeto
  //   return true 
  // }
  method esVacio(){
    return true
  }
  method aceptaIngredientesEncima(){ //tal vez cambiar el nombre porque no tiene mucho sentido para la bandeja
  //es más que anda para que tenga polimorfismo con los ingredientes
    return false
  }
}
