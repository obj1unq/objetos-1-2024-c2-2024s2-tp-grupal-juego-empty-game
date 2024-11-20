import extras.*
import wollok.game.*
import personajes.personaje.*
import juego.*

//---------------------------------Timer---------------------------------------


object timer {

    var segundos = 0
    var minutos  = 0

    method position() {
        return game.at(11, game.height() - 1 )
    }

    method text() {
        return minutos.toString() +":"+ segundos.toString()
    }

    method textColor() {
        return "FFFFFF"
    }

    method tick() {
        if(segundos < 60){
            segundos += 1
        }else{
            minutos += 1
            segundos = 0
            segundos += 1
        }
    }

}
//----------------------------------------------HUD-----------------------------
object barra{
    var property image =  "blacklong.png"
    var property position = game.at(0, 14)

}
//----------------------------------BARRA DE VIDA-----------------------------

object puntosDeVida {
    var vida = 100
    var property image =  "barravida-100.png"
    var property position = game.at(0, 14)

    method curarse(cura){
        game.sound("cura-sonido.mp3").play()
        vida = 100.min(vida + cura) 
        self.actualizar()
    }

    method herir(cant) {
        vida = 0.max(vida - cant)
        self.actualizar()
        self.revisarMorir()
    }

    method revisarMorir() {
        if (vida == 0) {
            self.muerte()
        }
    }

    method muerte() {
        juego.jugador().sonidoMuerte()
        game.clear()
        // pantalla muerte
        game.schedule(1000, {game.stop()})
    }

    method actualizar(){
        self.image("barravida-" + vida.toString() + ".png")
    }
}

//----------------------------------------------MUNICION-----------------------------

object cargador {
    var property  municion = juego.jugador().arma().municion() 
    var property position = game.at(4, 14)

    method image(){
        return juego.jugador().arma().hudMunicion() + municion.toString() + ".png"
    }
    
    method recargar(balas){
        juego.jugador().sonidoRecarga()
        municion += balas
        municion = municion.min(juego.jugador().arma().municionMaxima()) 
    }

    method validarAtaque(){
        if (municion == 0){
            juego.jugador().sinMunicion()
            self.error("")
        }
    }

    method quitarMunicion(cantidad) {
        municion -= cantidad
        managerItems.posiblesBalas(municion)
    }
}


//----------------------------------------------ORO-----------------------------
object oroObtenido {

    method position() {
        return game.at(10, game.height() - 1 )
    }

    method text() {
        return juego.jugador().oro().toString()
    }

    method textColor() {
        return "ffff00"
    }

    method impactoProyectil(danio) {}

}


//----------------------------------------------energia-----------------------------


object barraDeEnergia {

    var property image =  "energia-"+ energia.toString() + ".png"
    var property energia = 10

    method position() {
            return game.at(12, 14)
    }
    
    method validarEnergia(){
        if (energia > 0){
            self.quitarEnergia(1)
        }
        else {self.error("")}
    }

    method quitarEnergia(cantidad) {
        energia -= cantidad
        self.image("energia-"+ energia.toString() + ".png") 
    }

    method recargarEnergia(){
        energia = (energia + 1).min(10)
        self.image("energia-"+ energia.toString() + ".png") 
    }

}