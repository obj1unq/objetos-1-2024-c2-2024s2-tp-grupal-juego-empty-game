import wollok.game.*
import posiciones.*

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
}