import comestibles.*
import objetosCocina.*
import objetosParaTests.*
import clientes.*

//HACER UNA CLASE POSICION DE OBJETO?
object restaurante {

    const property muebles = [tacho3, mesada1, mesada2, horno] 
    const property ingredientesSueltos = [tomate, queso, masa] //acá guarda solo los ingredientes sueltos. NO TODOS -> los que tiene en la mano no los guarda, las factories no son ingredientes son muebles 
    const property filasDeClientes = []
//  
    method hayObjetoDeListaAqui(lista, position){
      return lista.any({objeto => objeto.position() == position})
    }

    method objetoDeListaAqui(lista, position) {
      //return lista.findOrElse({objeto => objeto.position() == position}, muebleFantasma)
      //return lista.findOrElse({objeto => objeto.position() == position}, muebleFantasma) //aca el problema es que hay que repetir codifo para cliente o cambiarlo
      return lista.find({objeto => objeto.position() == position})
    }

//

    method muebleAqui(position) {
          return self.objetoDeListaAqui(muebles, position)
        }

    method hayMuebleAqui(position){
      return self.hayObjetoDeListaAqui(muebles, position)
    }
  
//probar:
    method hayClienteAqui(position) {
      return 
      self.hayObjetoDeListaAqui(filasDeClientes, position) //creo que debería ser position + 1 porque esta el mueble y después el cliente? o ver otra forma
      //la factory de clientes tiene que agregar los clientes a la fila del restaurante
    }
    
    method clienteAqui(position) { //igual que hayClienteAqui(p)
      return self.objetoDeListaAqui(filasDeClientes, position)
    }
    
}

