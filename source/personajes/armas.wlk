import wollok.game.*
import personaje.*
import posiciones.*
import juego.*
import extras.*
import hud.*
import proyectiles.*

class Arma {

    const cadencia
    var estado = estadoAtacar 
    
    method disparar(dir,pos) {
        juego.jugador().animacionAtaque(dir)
        cargador.quitarMunicion(1)
        self.cicloEstado()
    }

    method gatillar(dir,pos) {
        estado.gatillar(dir,pos,self)
    }

    method cicloEstado() {
        estado = estadoEsperar
        game.schedule(cadencia, {estado = estadoAtacar})
    }

    method hudMunicion()
}


object pistola inherits Arma(cadencia=500) {

    override method disparar(dir,pos) {
        super(dir,pos)
        const balaNueva = new Bala(image="bala-" + dir.toString() + ".png", position=dir.siguientePosicion(pos))
        game.addVisual(balaNueva)
        balaNueva.nuevoViaje(dir)
    }

    override method hudMunicion(){
        return "balas-"
    }

}

object escopeta inherits Arma(cadencia=800) {

    override method disparar(dir,pos) {
        super(dir,pos)
        const balaNueva = new BalaEscopeta(image="balaEscopeta-" + dir.toString() + ".png", position=dir.siguientePosicion(pos))
        game.addVisual(balaNueva)
        balaNueva.nuevoViaje(dir)
    }

    override method hudMunicion(){
        return "cartuchos-"
    }
}

object manosMagicas inherits Arma(cadencia=800) {

    override method disparar(dir,pos) {
        super(dir,pos)
        const bolaNueva = new BolaDeFuego(image="bola-" + dir.toString() + ".png", position=dir.siguientePosicion(pos))
        game.addVisual(bolaNueva)
        bolaNueva.nuevoViaje(dir)
    }

    override method hudMunicion(){
        return "mana-"
    }
}

object estadoAtacar {
    method gatillar(dir,pos,arma) {
        arma.disparar(dir,pos)
    }
}

object estadoEsperar {
    method gatillar(dir,pos,arma) {}
}