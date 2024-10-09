import wollok.game.*
import posiciones.*
import extras.*
import hud.*

object dangalf {

    method nombre(){
        return "dangalf"
    }

    method imagenInicial(){
        return "dangalf-normal-arriba.png"
    }

    method imagenAtaque(dir) {
        return self.nombre() + "-ataque-" + dir.toString() + ".png"
    }

    method imagenNormal(dir) {
        return self.nombre() + "-normal-" + dir.toString() + ".png"
    }

    method especial(){

    }

    method sonidoAtaque(){
        game.sound("magia1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("wizard-death.mp3").play()
    }

    method hudMunicion(){
        
    }
    
    method municionImagen(){
        return "potion.png"
    }
    method sinMunicion(){
        game.sound("mago-sin-municion.mp3").play()
    }

    method sonidoRecarga(){
        game.sound("mana.mp3").play()
    }
}