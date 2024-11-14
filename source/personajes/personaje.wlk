import wollok.game.*
import posiciones.*
import extras.*
import hud.*
import noel.*
import dangalf.*

class Personaje { 
    //Imagen y posicion
    var property image = self.imagenInicial()
    var property position = game.at(5,5)
    //Estadisticas
    var property visualAmmo = self.municionImagen()
    var property oro = 0

    var property puedeDisparar = true

    method imagenInicial()
    method imagenNormal(dir)
    method imagenAtaque(dir)
    method sonidoAtaque()
    method disparar(dir,pos)
    method municionImagen()
    method cura(num)


    //var property zombiesAsesinados = 0   - A implementar

    method visualHealth(numero) {
        return self.cura(numero)
    }
    
    // -------------movimiento-------------------------------
    
    method mover(direccion) {
        barraDeEnergia.validarEnergia()
        self.validarMover(direccion)
	    position = direccion.siguientePosicion(position)
        self.image(self.imagenNormal(direccion))
        managerItems.revisarPorItems(position)
	}

    method validarMover(direccion) {
		const siguiente = direccion.siguientePosicion(position)
		tablero.validarDentro(siguiente)
        self.validarTraspasables(siguiente)
	}

    method validarTraspasables(posicion) {
        if(!self.hayTraspasables(posicion)) {
            self.error("")
        }
    }

    method hayTraspasables(posicion) {
        return game.getObjectsIn(posicion).all({o => o.traspasable()})
    }

    // -------------ataque-------------------------------
    
    method ataque(direccion) { 
        self.image(self.imagenNormal(direccion))
        cargador.validarAtaque(direccion)
        self.animacionAtaque(direccion)
        self.disparar(direccion,position)
        self.cadenciaArma()                                               
    }
    method animacionAtaque(direccion) {                                                       
        self.image(self.imagenAtaque(direccion))
        game.schedule(200,{self.image(self.imagenNormal(direccion))})
        self.sonidoAtaque()
    }

    method cadenciaArma(){
        puedeDisparar = false
        game.schedule(self.cadencia(), {puedeDisparar = true})
    }

    method cadencia(){
        return 500
    }
    // -------------items-------------------------------

    method herir(cantidad) {
        puntosDeVida.herir(cantidad)
    }

    method obtenerOro(valor) {
        game.sound("oro-sonido.mp3").play()
        oro += valor
    }

// -------------energia-------------------------------

}
