import Chefs.*
import comestibles.*


import wollok.game.*

class Cliente{
    var property position = game.at(0,7) //o donde esté la puerta
    var property image = ""
    var property pedidoQueEspero = #{}
    var property emocion = "" //las emocines podrían ser estados
    const nivelDePaciencia = null //depende del tipo de cliente

    method avanzarAHacerPedido() {
      //podría ser un tipo de animación donde avanza paso por paso hasta llegar a la mesa de recepción para hacer el pedido
      self.generarPedido()
      self.decirPedido()
    }

    method decirPedido(){
      //aca debería aparecer una imagen del pedido que quiere. una imagen aparte arriba del cliente
    }

    method generarPedido() {
      pedidoQueEspero = #{}
      //un randomicer que te devuelva una lista random de ingredientes 
    }

    method recibirPedido(pedido) {
      self.reaccionarAPedido(pedido)
      self.pagarPedido()
    }

    method reaccionarAPedido(pedido) {
      if(self.esLoQueEsperaba(pedido)){
        emocion = "" //aca debería cambiar el estado?
      } else{
        emocion = "" //aca debería cambiar el estado?
      }
    }

    method esLoQueEsperaba(pedido){ 
      return self.esUnaPiza(pedido) and pedido.ingredientes() == pedidoQueEspero //puede recibir un ingrediente solo pero eso lo va a hacer enojar.
    }

    method esUnaPiza(pedido){
        return  pedido.aceptaIngredientesEncima()
    }

    method pagarPedido() {
      return //pagar pedido va a ser dar la plata degun una cuenta que tiene que involucrar la paciencia del cliente
    }
}

/*
    tiene que tener posición e imagen -> sería facil que solo se mueva derecho para entrar y salir
    tienen saber pedir un pedido -> imagen
    tiene que saber que pedido quería -> para despues comprarlo con el que le dan
    tiene que devolver una opinión (la opinión afecta el pago?) -> emojis
    tienen que tener la plata para pagar su pedido 
*/
/*
    -Herencia con clientes -> clientes quisquillosos, clientes que perdonan, cliente que acepta de malas.

*/
/*
creo que se va a tener que hacer una factory de clientes con un randomizer para lo que quieran pedir.
*/