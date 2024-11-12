import mapa.*
import comestibles.*
import restaurante.*
import chefs.*


import wollok.game.*

class Mueble {
  const property position = game.center() 
  const image = "" 
  var contenido = [] //bandejaVacia es un objeto que representa el no tener nada
  var property maxCapacidad = 1

  method usarse(chef){ //para con 1 solo boton "interactuar" sea algo general y el mueble ve como se arregla en la interaccion
    if(not self.tieneAlgo()){ //si no tiene nada encima asume que el chef intenta dejar algo
      self.validarRecibir(chef)
      self.accionRecibir(chef)
    } else { //sino asume que el chef intenta agarrar algo 
      self.validarDar(chef)
      self.accionDar(chef)
    }
  }

  method tieneAlgo() {
    return not contenido.isEmpty()
  }

  method validarRecibir(chef){
    if(not self.tieneEspacio()){
      game.say(chef, "no hay espacio para dejar algo aqui") //el error que dice el chef
      self.error("no hay espacio en el mueble") //no se si dejar vacio o no aca
    }
  }

  method tieneEspacio() { //template method para ver si tiene espacio
    return contenido.size() + 1 <= maxCapacidad 
  }

  method validarDar(chef){
    if(not chef.tengoBandejaVacia()){ //lo mismo que recibir acá
      game.say(chef, "no puedo agarrar algo si tengo las manos llenas")
      self.error("el chef no puede agarrar lo que hay en el mueble")
    }
  }

  method accionRecibir(chef){
    contenido.add(chef.bandeja())
  }

  method accionDar(chef){
    chef.recibir(self.objetoADar(chef))
   self.eliminarLoDado() 
  }

  method objetoADar(chef){
    return self.primerIngrediente()
  }

   method eliminarLoDado(){ //template method para las factories
    contenido.remove(self.primerIngrediente())
   }

  method contenido(){
    return contenido
  }

  method estaLibre(){
    return contenido.esVacio() || self.tienePiza() //buscar mejor nombre para el mensaje de "esVacio"?
  }

    method tienePiza(){
    return self.primerIngrediente().aceptaIngredientesEncima()
  }
  
  method primerIngrediente(){
    return contenido.head()
  }

}



class Horno inherits Mueble{
  var property temperatura = 0

  override method maxCapacidad(){
    return 2
  }

  //estaria bueno agregar un metodo de subir de nivel le sube la capacidad maxima al horno y además descuenta plata de la caja

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
      self.primerIngrediente().recibirIngrediente(ingrediente)
    } else { 
      super(chef) //sino, el ingrediente se agrega arriba del mueble y listo, se tiene que ver ahí la imagen
    }  
    ingrediente.serDejadoAqui(self.position())
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

  override method maxCapacidad(){
    return 0
  }

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