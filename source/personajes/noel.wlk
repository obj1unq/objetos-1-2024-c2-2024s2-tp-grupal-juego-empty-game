import wollok.game.*
import posiciones.*
import proyectiles.*

object noel {

    method disparar(direccion,posDada) {
       const balaNueva = new Bala(image="bala-1-" + direccion.toString() + ".png", position=direccion.siguientePosicion(posDada))
        game.addVisual(balaNueva)
        game.onTick(40, "viajeDeProyectil".identity(), {balaNueva.disparoHacia(direccion)})
    }

    method imagenInicial(){
        return "noelnuevo-normal-arriba.png"
    }

    method imagenAtaque(direccion) {
        return "noelnuevo-ataque-" + direccion.toString() + ".png"
    }

    method imagenNormal(direccion) {
        return "noelnuevo-normal-" + direccion.toString() + ".png"
    }

    method especial(){}

    method sonidoAtaque(){
        game.sound("tiro1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("noel-muerte-sonido.mp3").play()
    }
}