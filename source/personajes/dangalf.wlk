import proyectiles.*
import wollok.game.*
import posiciones.*
import extras.*
import hud.*
import personajes.personaje.*

object dangalf inherits Personaje() {


    override method cadencia(){
        return 300
    }
//-------------items------------------------------------------

    override method cura(numero){
        return "cura" + numero + "-mago.png"
    }

    override method municionImagen(){
        return "potion.png"
    }

//-----------ataque-movimiento--------------------------------

    override method disparar(direccion, posDada) {
        const bolaNueva = new BolaDeFuego(image="bola-" + direccion.toString() + ".png", position=direccion.siguientePosicion(posDada))
        game.addVisual(bolaNueva)
        bolaNueva.nuevoViaje(direccion)
    }

    override method imagenInicial(){
        return "dangalf-normal-arriba.png"
    }

    override method imagenAtaque(dir) {
        return "dangalf-ataque-" + dir.toString() + ".png"
    }

    override method imagenNormal(dir) {
        return "dangalf-normal-" + dir.toString() + ".png"
    }

    method especial(){}

    override method sonidoAtaque(){
        game.sound("magia1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("wizard-death.mp3").play()
    }

//------------hud-------------------------------------------

    method hudMunicion(){
        return "mana-"
    }
    
    method sinMunicion(dir){
        game.sound("mago-sin-municion.mp3").play()
    }

    method sonidoRecarga(){
        game.sound("mana.mp3").play()
    }

}