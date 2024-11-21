import proyectiles.*
import wollok.game.*
import posiciones.*
import extras.*
import hud.*

object dangalf {

    method disparar(direccion, posDada) {
        const bolaNueva = new BolaDeFuego(image="bola-1-" + direccion.toString() + ".png", position=direccion.siguientePosicion(posDada))
        game.addVisual(bolaNueva)
        bolaNueva.nuevoViaje(direccion)
    }

    method dispararEspecial() {
      const rayoArriba = new Especial(image="rayoGrande.png", position = arriba)
      const rayoAbajo = new Especial(image="rayoGrande.png", position = abajo)
      const rayoIzquierda = new Especial(image="rayoGrande.png", position = izquierda)
      const rayoDerecha = new Especial(image="rayoGrande.png", position = derecha)
        game.addVisual(rayoArriba)
        rayoArriba.nuevoViaje(arriba)
        game.addVisual(rayoAbajo)
        rayoAbajo.nuevoViaje(abajo)
        game.addVisual(rayoIzquierda)
        rayoIzquierda.nuevoViaje(izquierda)
        game.addVisual(rayoDerecha)
        rayoDerecha.nuevoViaje(derecha)
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

    method hudMunicion(){
        return "mana-"
    }
    
    method municionImagen(){
        return "potion.png"
    }
    method sinMunicion(dir){
        game.sound("mago-sin-municion.mp3").play()
    }

    method sonidoRecarga(){
        game.sound("mana.mp3").play()
    }

    method cura(numero){
        return "cura" + numero + "-mago.png"
    }
}