import proyectiles.*
import wollok.game.*
import posiciones.*

object dangalf {

    method disparar(direccion, posDada) {
        const bolaNueva = new BolaDeFuego(image="bola-1-" + direccion.toString() + ".png", position=direccion.siguientePosicion(posDada))
        game.addVisual(bolaNueva)
        game.onTick(150, "viajeDeProyectil".identity(), {bolaNueva.disparoHacia(direccion)})
    }

    method imagenInicial(){
        return "dangalf-normal-arriba.png"
    }

    method imagenAtaque(dir) {
        return "dangalf-ataque-" + dir.toString() + ".png"
    }

    method imagenNormal(dir) {
        return "dangalf-normal-" + dir.toString() + ".png"
    }

    method especial(){}

    method sonidoAtaque(){
        game.sound("magia1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("wizard-death.mp3").play()
    }
}