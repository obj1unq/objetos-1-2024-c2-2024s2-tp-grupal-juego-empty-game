import wollok.game.*
import posiciones.*
import extras.*
import hud.*



object noel {

    method nombre() {
        return "noelnuevo"
    }

    method imagenInicial(){
        return "noelnuevo-normal-arriba.png"
    }

    method imagenAtaque(direccion) {
        return self.nombre() + "-ataque-" + direccion.toString() + ".png"
    }

    method imagenNormal(direccion) {
        return self.nombre() + "-normal-" + direccion.toString() + ".png"
    }

    method especial(){

    }

    method sonidoAtaque(){
        game.sound("tiro1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("noel-muerte-sonido.mp3").play()
    }

    method hudMunicion(){
        return "balas-"
    }

    method municionImagen(){
        return "balas.png"
    }
    method sinMunicion(){
        game.sound("sin-balas.mp3").play()
    }

    method sonidoRecarga(){
        game.sound("pistola-recarga.mp3").play()
    }
}