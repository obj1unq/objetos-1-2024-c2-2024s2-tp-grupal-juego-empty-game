import chefs.*
import comestibles.*


import wollok.game.*

class Cliente{
    var property position = game.at(0,7) //o donde esté la puerta
    var property image = null
    var property pedidoQueEspero = #{}
    var property emocion = "" //las emocines podrían ser estados
    var nivelDePaciencia = null //depende del tipo de cliente

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
      self.pagarPedido(pedido)
    }

    method reaccionarAPedido(pedido) {
      if(self.esLoQueEsperaba(pedido)){
        emocion = "" //aca debería cambiar el estado?
      } else{
        nivelDePaciencia = nivelDePaciencia - 20
        emocion = "" //aca debería cambiar el estado?
      }
    }

    method esLoQueEsperaba(pedido){ 
      return self.esUnaPiza(pedido) and pedido.ingredientes() == pedidoQueEspero //puede recibir un ingrediente solo pero eso lo va a hacer enojar.
    }

    method esUnaPiza(pedido){
        return  pedido.aceptaIngredientesEncima()
    }

    method plataAPagarPorPedido(pedido) {
      return pedido.precio() * nivelDePaciencia / 100 
    }

    method pagarPedido(pedido) {
      //caja.recibir(slef.plataAPagarPorPedido(pedido))
      //hacer caja.
    }
}

class ClienteNormal inherits Cliente(nivelDePaciencia = 100, image = "image_clieneNormal.png"){}

class ClienteQuisquilloso inherits Cliente(nivelDePaciencia = 80, image = "image_clieneQuisquilloso.png"){}

class ClientePaciente inherits Cliente(nivelDePaciencia = 110, image = "image_clienePaciente.png"){}
