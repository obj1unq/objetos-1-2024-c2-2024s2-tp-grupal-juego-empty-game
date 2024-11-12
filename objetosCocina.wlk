import mapa.*
import comestibles.*
import restaurante.*
import chefs.*


import wollok.game.*

class Mueble {
  const property position = game.center() 
  const image = "" 
  var contenido = bandejaVacia //es un objeto que representa el no tener nada
  //var property maxCapacidad = 1

  method usarse(chef){ //para con 1 solo boton "interactuar" sea algo general y el mueble ve como se arregla en la interaccion
    if(not chef.tengoBandejaVacia()){ //si el cheff tiene algo en su bandeja asume que tiene que recibir algo
      self.validarRecibir(chef)
      self.accionRecibir(chef)
    } else { //sino asume que el chef intenta agarrar algo 
      self.validarDar(chef)
      self.accionDar(chef)
    }
  }

  method tieneAlgo() {
    return not contenido.esVacio()
  }

  method validarRecibir(chef){
    if(self.tieneAlgo()){ //si tiene algo ya no puede recibir lo que tiene el chef
      chef.error("no hay espacio para dejar algo aqui")  //esta bien o mejor que lo diga el mueble?
    }
  }

  method validarDar(chef){
    if(not chef.tengoBandejaVacia()){ //si el chef no tiene espacio no puede agarrar lo del mueble
      chef.error("no puedo agarrar algo si tengo las manos llenas")
    }
  }

  method accionRecibir(chef){
    contenido = chef.bandeja()
    chef.soltar() //esto en el chef hace que tenga una bandeja vacia otra vez
  }

  method accionDar(chef){
    chef.recibir(self.objetoADar(chef))
    self.eliminarLoDado() 
  }

  method objetoADar(chef){
    return contenido
  }

   method eliminarLoDado(){ //template method para las factories -> mo hace nada eso ya que no tiene "contenido"
    contenido = bandejaVacia
   }

  method contenido(){
    return contenido
  }

  method estaLibre(){
    return not self.tieneAlgo() || self.tienePiza() //buscar mejor nombre para el mensaje de "esVacio"?
  }

    method tienePiza(){
    return contenido.aceptaIngredientesEncima()
  }
  
  // method primerIngrediente(){ al final no es necesario esto por ahora
  //   return contenido.head()
  // }

}

// object muebleFantasma inherits Mueble{ //esto es para evitar el error de que no se encuentre ningun mueble en el find

//   override method usarse(chef){
//     game.say(restaurante, "no hay ningun mueble Aqui")
//   }

// }


class Horno inherits Mueble{
  var property temperatura = 0

  override method accionRecibir(chef){
    super(chef)
    self.cocinar()
  }

  method cocinar() { 
    game.onTick(2500, self, {
                                contenido.forEach({pizza => pizza.serCocinada()})  
                            })
    game.onTick(2500, self, {self.subirNivelDeHorno()})
  } 

  method subirNivelDeHorno(){
    temperatura = (temperatura + 1).min(3)
    self.actualizarEstadoHorno()
  }

  method actualizarEstadoHorno() {
    if (temperatura == 3) self.simularFuego()
  }

  method simularFuego() {
    //esto sería mejor que hagamos que aparezca dibujos de humo arriba del horno y ya está
  }

}

class Mesada inherits Mueble{

  override method accionRecibir(chef){
    const ingrediente = chef.bandeja()
    if(self.tienePiza()){ //si la mesada tiene una pizza entonces el ingrediente se agrega a la lista de la masa
      contenido.recibirIngrediente(ingrediente)
    } else { 
      super(chef) //sino, el ingrediente se agrega arriba del mueble y listo, se tiene que ver ahí la imagen
    }  
    ingrediente.serDejadoAqui(self.position()) //REVISAR SI ESTO SIRVE DE ALGO
  }

}

class Tacho inherits Mueble{

  override method accionRecibir(chef){
    //mandarle un mensaje al chef de que si tiro la basura entonces cambie su imagen?
    chef.bandeja(bandejaVacia) 
    //remove visual acá?
  }

}

class Dispencer inherits Mueble{}

class PilaIngrediente inherits Mueble {

  override method eliminarLoDado(){}

  override method objetoADar(chef){
    return self.nuevoIngrediente(chef)
  }

  method nuevoIngrediente(chef)

   method serSostenido(chef){} //ELIMINAR

}

object estacionTomate  inherits PilaIngrediente(image = "tomate_inicial.png", position = game.at(2, 2)){

  override method nuevoIngrediente(chef){
    return new Tomate(position= chef.position())
  }

}

object estacionMasa inherits PilaIngrediente(image = "masa_inicial.png", position = game.at(4,2)){

    override method nuevoIngrediente(chef){
      return new Masa(position= chef.position())
    }

}

object estacionQueso inherits PilaIngrediente(image = "queso_inicial.png", position = game.at(6,2)) {

  override method nuevoIngrediente(chef){
    return new Queso(position = chef.position())
  }

}

object estacionAceituna inherits PilaIngrediente(image = "aceituna_factory.png", position = game.at(9,5)) {

    override method nuevoIngrediente(chef){
      return new Aceituna(position = chef.position())
    }
  }

object estacionHongo inherits PilaIngrediente(image = "hongo_factory.png", position = game.at(9,7)){

  override method nuevoIngrediente(chef){
    return new Hongo(position=chef.position())
  }

}

object estacionHuevo inherits PilaIngrediente(image = "huevos_factory.png", position = game.at(9,3)){

  override method nuevoIngrediente(chef){
    return new Huevo(position=chef.position())
  }

}

object estacionAtun inherits PilaIngrediente(image = "atun_factory.png", position = game.at(9,1)) {

  override method nuevoIngrediente(chef){
    return new Atun(position = chef.position())
  }

}