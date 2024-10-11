import wollok.game.*
import posiciones.*
import extras.*
import hud.*
import noel.*
import dangalf.*

object personaje {
    //Imagen y posicion
    var property pj = noel
    var property image = pj.imagenInicial()
    var property position = game.at(5,5)
    //Estadisticas
    var property vida = 100 //que sea un manager de vida aparte
    var property visualAmmo = pj.municionImagen()
    var property oro = 0

    //var property zombiesAsesinados = 0   - A implementar

    // -------------movimiento-------------------------------
    
    method mover(direccion) {
        self.validarMover(direccion)
	    position = direccion.siguientePosicion(position)
        self.image(pj.imagenNormal(direccion))
	}

    method validarMover(direccion) {
		const siguiente = direccion.siguientePosicion(position)
		tablero.validarDentro(siguiente)
	}

    // -------------ataque-------------------------------
    
    method ataque(direccion) { 
        self.image(pj.imagenNormal(direccion))                                                      
        cargador.validarAtaque()                                                             
        self.image(pj.imagenAtaque(direccion))
        game.schedule(200,{self.image(pj.imagenNormal(direccion))})
        pj.sonidoAtaque()
    }

    // -------------muerte-------------------------------

    method revisarMorir() {
        if (vida == 0) {
            self.muerte()
        }
    }

    method muerte() {
        pj.sonidoMuerte()
        //game.sound("muerte-musica.mp3").play()
        //game.say(self, "morí reyes TT")
        game.allVisuals().forEach({visual => game.removeVisual(visual)})
        game.boardGround("pantalla-muerte.jpg")
        game.schedule(300, {game.stop()})
    }

    // -------------Prueba de curarse-------------------------------

	method curarse(cura){
        game.sound("cura-sonido.mp3").play()
        vida += cura
        vida = vida.min(100) 
        puntosDeVida.actualizar()
    }

    method herir(cantidad) {
        vida = (vida - cantidad).max(0)
        puntosDeVida.actualizar()
        self.revisarMorir()
    }

    method obtenerOro(valor) {
        game.sound("oro-sonido.mp3").play()
        oro += valor
    }

}

// -------------estados-------------------------------