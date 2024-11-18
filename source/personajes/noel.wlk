import personaje.*
import wollok.game.*
import posiciones.*
import extras.*
import hud.*
import armas.*
import proyectiles.*

object noel inherits Personaje(arma=pistola) {

//-------------items------------------------------------------

    override method cura(numero){
        return "cura" + numero + "-noel.png"
    }

     override method municionImagen(){
        return "balas.png"
    }

//-----------ataque-movimiento--------------------------------

    override method imagenInicial(){
        return "noel-normal-arriba.png"
    }
   
    override method imagenAtaque(direccion) {
        return "noel-ataque-" + direccion.toString() + ".png"
    }

    override method imagenNormal(direccion) {
        return "noel-normal-" + direccion.toString() + ".png"
    }

    method especial(){}

    override method sonidoAtaque(){
        game.sound("tiro1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("noel-muerte-sonido.mp3").play()
    }

//------------hud-------------------------------------------

        override method sinMunicion(){
        game.sound("sin-balas.mp3").play()
    }

    method sonidoRecarga(){
        arma.sonidoDeRecarga()
    }

//---------------------arma--------------------------

    method cambiarAEscopeta() {
        arma = escopeta
    }

    method cambiarAPistola() {
        arma = pistola
    }

}


