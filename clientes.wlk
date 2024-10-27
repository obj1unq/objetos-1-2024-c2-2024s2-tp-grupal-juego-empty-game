import chefs.*
import comestibles.*


import wollok.game.*

class Cliente{
    var property position = game.at(0,7) //o donde esté la puerta
    var property image = null
    var property pedidoQueEspero = #{}
    var property emocion = neutral //las emocines podrían ser estados
    var nivelDePaciencia = null //depende del tipo de cliente

    method avanzarAHacerPedido() {
      //podría ser un tipo de animación donde avanza paso por paso hasta llegar a la mesa de recepción para hacer el pedido
      self.generarPedido()
      self.decirPedido()
    }

    method decirPedido(){
      //aca debería aparecer una imagen del pedido que quiere. una imagen aparte arriba del cliente y solo dure x minutos
    }

    method generarPedido() {
      const ingredientePrincipal = #{"aceitunas", "queso", "atun", "hongos"}.randomized().head()

      pedidoQueEspero = #{"salsa", "queso"} + #{ingredientePrincipal}

    }

    method recibirPedido(pedido) {
      self.reaccionarAPedido(pedido)
      emocion.mostrarse(self)
      self.pagarPedido(pedido)
    }

    method reaccionarAPedido(pedido) {
      if(self.esLoQueEsperaba(pedido)){
        emocion = feliz 
      } else{
        nivelDePaciencia = nivelDePaciencia - 20
        emocion = decepcionado
      }
    }

    method esLoQueEsperaba(pedido){  //puede recibir un ingrediente solo pero eso lo va a hacer enojar.
      return self.esUnaPiza(pedido) and self.esLaPizzaQuePedi(pedido)
    }

    method esLaPizzaQuePedi(pedido){
      return pedido.ingredientes().map({ingrediente => ingrediente.id()}) == pedidoQueEspero //fijarse en la comparacion si lo pasa a set el map
    }

    method esUnaPiza(pedido){
        return  pedido.aceptaIngredientesEncima()
    }

    method plataAPagarPorPedido(pedido) {
      return pedido.precio() * nivelDePaciencia / 100 
    }

    method pagarPedido(pedido) {
      //caja.recibir(self.plataAPagarPorPedido(pedido))
      //hacer caja.
    }
}

object neutral {
  method mostrarse(cliente){}
}
object feliz {
  const property image = "imagen emotion feliz"
  method mostrarse(cliente){
    game.addVisual(cliente.position().up()) //no sé como hacer que dure solo un rato la imagen
  }
}
object decepcionado {
  const property image = "imagen emotion decepcionado/ enojado/ triste"
  method mostrarse(cliente){
    game.addVisual(cliente.position().up()) //no sé como hacer que dure solo un rato la imagen
  }
}

class ClienteNormal inherits Cliente(nivelDePaciencia = 100, image = "image_clieneNormal.png"){}

class ClienteQuisquilloso inherits Cliente(nivelDePaciencia = 80, image = "image_clieneQuisquilloso.png"){}

class ClientePaciente inherits Cliente(nivelDePaciencia = 110, image = "image_clienePaciente.png"){}
