import personaje.*
import wollok.game.*
import posiciones.*
import extras.*
import hud.*
import proyectiles.*

object noel inherits Personaje() {

//-------------items------------------------------------------

    override method cura(numero){
        return "cura" + numero + "-noel.png"
    }

     override method municionImagen(){
        return "balas.png"
    }

//-----------ataque-movimiento--------------------------------

    override method disparar(direccion,posDada) {
        const balaNueva = new Bala(image="bala-1-" + direccion.toString() + ".png", position=direccion.siguientePosicion(posDada))
        game.addVisual(balaNueva)
        balaNueva.nuevoViaje(direccion)
    }

    override method imagenInicial(){
        return "noelnuevo-normal-arriba.png"
    }
   
    override method imagenAtaque(direccion) {
        return "noelnuevo-ataque-" + direccion.toString() + ".png"
    }

    override method imagenNormal(direccion) {
        return "noelnuevo-normal-" + direccion.toString() + ".png"
    }

    method especial(){}

    override method sonidoAtaque(){
        game.sound("tiro1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("noel-muerte-sonido.mp3").play()
    }

//------------hud-------------------------------------------

    method hudMunicion(){
        return "balas-"
    }

    method sinMunicion(dir){
        game.sound("sin-balas.mp3").play()
    }

    method sonidoRecarga(){
        game.sound("pistola-recarga.mp3").play()
    }

}