import personaje.*
import wollok.game.*
import posiciones.*
import extras.*
import hud.*
import proyectiles.*

object noel inherits Personaje() {

    var property armaEquipada = escopeta

    override method cadencia(){ return armaEquipada.cadencia()}
//-------------items------------------------------------------

    override method cura(numero){
        return "cura" + numero + "-noel.png"
    }

     override method municionImagen(){
        return "balas.png"
    }

//-----------ataque-movimiento--------------------------------

    override method disparar(direccion,posDada) {
        if(self.esPistola(armaEquipada))
            {const balaNueva = new Bala(image="bala-" + direccion.toString() + ".png", position=direccion.siguientePosicion(posDada))
            game.addVisual(balaNueva)
            balaNueva.nuevoViaje(direccion)}
        else
            {const balaNueva = new BalaEscopeta(image="balaEscopeta-" + direccion.toString() + ".png", position=direccion.siguientePosicion(posDada))
            game.addVisual(balaNueva)
            balaNueva.nuevoViaje(direccion)}
    }

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

    method hudMunicion(){
        return "balas-"
    }

    method sinMunicion(dir){
        game.sound("sin-balas.mp3").play()
    }

    method sonidoRecarga(){
        armaEquipada.sonidoDeRecarga()
    }

//---------------------arma--------------------------

    method esPistola(arma){
        return arma == pistola
    }
}

object pistola {

    method cadencia(){
        return 500
    }

    method sonidoDeRecarga(){
        game.sound("arma-recarga.mp3").play()
    }

}

object escopeta {

    method cadencia(){
        return 1000
    }

    method sonidoDeRecarga(){
        game.sound("pistola-recarga.mp3").play()
    }

}


