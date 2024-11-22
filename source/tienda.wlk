import wollok.game.*
import juego.*
import personajes.personaje.*
import hud.*


object tienda{
    
    //var property tienda = "Tienda.png"
    //var property vidaImagen = "VidaUp.png"
    //var property energiaImagen = "EnergiaUp.png"
    



    var property oroObtenido = juego.jugador().oro()
    
    method position() {
            return game.at(11,7) //TIENE QUE ESTAR EN EL MEDIO (?)
    }
    //Letra J
    method mejorarVida(){ //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiAlcanzaOro(puntosDeVida.precio())
        self.validarSiVidaEstaAlMax()
        puntosDeVida.subirMaximo(20)
        //Cambiar imgen si llego al maximo
        //sonido compra
        juego.jugador().restarOro(puntosDeVida.precio())  
    }

    //Letra L
    method mejorarEnergia(){ //Si Ya esta mejorado al maximo deberia poner fuer de stock en la tienda
        self.validarSiAlcanzaOro(barraDeEnergia.precio())
        self.validarSiEnergiaEstaAlMax()
        barraDeEnergia.subirMaximo(5)
        //Cambiar imgen si llego al maximo
        //sonido compra
        juego.jugador().restarOro(barraDeEnergia.precio())   
    }

    method validarSiAlcanzaOro(precio){
        if(oroObtenido < precio){self.error("")} //No alcanza el oro
    }

    method validarSiVidaEstaAlMax(){
        if(puntosDeVida.vidaMax() == 100){self.error("")} //La vida esta al maximo
    }

    method validarSiEnergiaEstaAlMax(){
        if(barraDeEnergia.energiaMaxima() == 20){self.error("")} //La energia esta al maximo
    }
}

