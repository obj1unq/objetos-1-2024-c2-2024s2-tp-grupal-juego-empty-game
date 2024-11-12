import restaurante.*
import chefs.*


import wollok.game.*


class Ingrediente { 
    var property position = game.center()    
    var property image = null 
    var property precio = null
    //conviene manejar 2 estados de ingedientes : me estan llevando y estoy libre.
    //si fue procesado o no debería ser otra propiedad que sea el novel de procesamiento -> objerto

   method esBandejaVacia(){
    return false
   }

   method aceptaIngredientesEncima() {
     return false
   }

    method serSostenido(chef) {
        game.removeVisual(self)
        position = chef.position() //hay que recordar que te esta llevando el chef y si le preguntan la prosicione ahí pregunta la posicon del chef + 1
        //se tiene quesi o si recordar al chef y pregunta a cada rato la posicion del chef +1 en la dir que se muebe para que se vea 
        //que estaen frente del cheff
    }

    method serDejadoAqui(nuevaPosition){
        //game.addVisual(nuevaPosition)
        position = nuevaPosition
    }

    method imagenIngredienteInicial() //ingrediente inicial y final tal vez podrían ser una constante y se declara en cada clase

    method imagenIngredienteFinal()

    method serProcesado(){
        if(self.image() == self.imagenIngredienteInicial()){ //esto es mejor hacerlo con objetos -> nivel de procesamiento
            image = self.imagenIngredienteFinal()
        }
    }

    method id() //que se compare con el hash de la clase en vez del "id"
    // masa.identity()

    method fueProcesado(){
        return false
    }
}


class Masa inherits Ingrediente( image = "masa_inicial.png", precio = 100 ) {
    const property ingredientes = #{} //aunque lo haga el chef la masa tiene que saber que tiene dentro.
    var property estado = cruda

    //override method serProcesado(){} 

    override method imagenIngredienteInicial(){
        return "masa_inicial.png" //imagen de masa redondita
    }

    override method imagenIngredienteFinal(){
        return "masa_final.png" //imagen de masa amazada
    }


    override method aceptaIngredientesEncima(){
      return true
    }

    method serCocinada(){
        self.actualizarEstado()
        estado.actualizarImagen(self) //y la imagen se va a actualizar automaticamente 
    }

    method actualizarEstado() {
        if (self.estado().esCrudo()) {
             estado = dorada //seria mejor un estado.pasarASuSiguieten (o Cocinar)
    } else {
            estado = quemada
        }
    }

    method recibirIngrediente(ingrediente){
        ingredientes.add(ingrediente)
        precio = precio + ingrediente.precio()
    }

    method tieneIngredientes() {
      return not ingredientes.isEmpty()
    }

    override method id(){
        return "masa"
    }
}

object cruda {
    method actualizarImagen(pizza){
        pizza.image("") //en lugar de settear la imagen debe contestar la imagen segun su estado
    }
    method esCrudo() { 
      return true
    }
}

object dorada {
    method actualizarImagen(pizza){
        pizza.image("")
    }
    method esCrudo() {
      return false
    }
}

object quemada {
    method actualizarImagen(pizza){
        pizza.image("")
    }
    method esCrudo() {
      return false
    }
}

class Queso inherits Ingrediente( image = "queso_inicial.png", precio = 200) {

        override method imagenIngredienteInicial(){
            return "queso_inicial.png"
        }

        override method imagenIngredienteFinal(){
            return "queso_final.png"
        }

        override method id(){
            return "queso"
        }
}

class Tomate inherits Ingrediente( image = "tomate_inicial.png", precio = 200) {
  
      override method imagenIngredienteInicial(){

        return "tomate_inicial.png"
      }

      override method imagenIngredienteFinal(){

        return "tomate_final.png"
      }

      override method id(){
            return "tomate"
        }
}

class Aceituna inherits Ingrediente( image = "aceituna_factory.png", precio = 200) {

    override method imagenIngredienteInicial(){
            return "aceituna_factory.png"
        }

        override method imagenIngredienteFinal(){
            return "aceituna_final.png"
        }

    override method id(){
            return "aceituna"
        }
}

class Huevo inherits Ingrediente( image = "huevo_inicial.png", precio = 200) {

    override method imagenIngredienteInicial(){
            return "huevo_inicial.png"
        }

        override method imagenIngredienteFinal(){
            return "huevo_final.png"
        }

    override method id(){
            return "huevo"
        }
}

class Atun inherits Ingrediente( image = "atun_factory.png", precio = 200) {

    override method imagenIngredienteInicial(){
            return "atun_factory.png"
        }

        override method imagenIngredienteFinal(){
            return "atun_final.png"
        }

    override method id(){
            return "atun"
        }
}

class Hongo inherits Ingrediente( image = "hongo_inicial.png", precio = 200) {

    override method imagenIngredienteInicial(){
            return "hongo_inicial.png"
        }

        override method imagenIngredienteFinal(){
            return "hongo_final.png"
        }

    override method id(){
            return "hongo"
        }
}


/*
    bebidas y postres: -> NO SON CLASE INGREDIENTE
    tiene que tener posición e imagen
    tiene que saber su precio
    tiene que saber que opción de bebida son 
        -> coca, sprite, fanta
        -> helado, torta, etc?
*/
class Bebida {}

class Postre {}