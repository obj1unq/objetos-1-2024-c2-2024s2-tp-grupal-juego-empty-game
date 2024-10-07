import wollok.game.*
import objetosCocina.*

class Pizza {

    var property position = null // va dependiendo donde este ubicado el horno
    var property nivelCoccion = 0
    const property ingredientes = #{} // se deberian agregar  la maza, el temate y queso ?  cuando sea crea el new Pizza
    // creo que se hace desde el chef  con su coleccion de ingrediente  sacarndo de el y agregando aca
    const property valor = 4500 //  a modificar 


    method image(){

        return "pizaa_" + nivelCoccion + ".png"
    }

    method serCocinada(){
        if (nivelCoccion < 2) nivelCoccion+1 else self.pizzaQuemada() // con los ontick del horno va cambiando solo, aca deberia  haber una imagen de pizza quemada  si se llega a 2 (o mas si decidimos tenes otros casos)

    } //  creo que si lo  hacemos desde el horno aca no hace falta  que manejemos  las imagenes  sino que campartan el mismo numero de imagen el horno y la pizza 
    // lo dejo por las dias

    method pizzaQuemada(){
        game.say(self,"me olvidaste en el horno :()")
    }

    method coccion(){

        return nivelCoccion
    }
}