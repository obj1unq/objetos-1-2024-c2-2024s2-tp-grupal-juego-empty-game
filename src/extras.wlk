import wollok.game.*
import barry.*
import posiciones.*
import randomizer.*
import menu.*

class Misil {
    var property position = game.at(9, 5)
    const property imagenes = ["misil1.png", "misil2.png", "misil3.png", "misil4.png", "misil5.png", "misil6.png"]
    var property imagenActualIndex = 0

    method image() {
        return imagenes.get(imagenActualIndex)
    }

    method tipo() {
        return "Misil"
    }
    
    method cambiarImagen() {
        imagenActualIndex = (imagenActualIndex + 1) % imagenes.size()
    }

    method mover(direccion) {
        var nuevaPosicion = direccion.siguiente(self.position()) 
        
        tablero.validarDentro(nuevaPosicion) // Validar el movimiento
        self.position(nuevaPosicion) // Actualizar la posición

        // Verifica si el misil llegó al borde izquierdo
        if (self.position().x() <= -1){ 
            game.removeVisual(self) // Elimina el misil actual
            game.removeTickEvent(self) // Elimina el onTick
            self.reaparecer() // Llama al método para reaparecer
        }
    }

    method reaparecer() {
        // Genera una nueva posición aleatoria en el eje Y
        var nuevaPosicionY = randomizer.anyY()
        // Crea un nuevo misil en la posición a la derecha
        const nuevoMisil = new Misil(position = game.at(12, nuevaPosicionY))
        game.addVisual(nuevoMisil) // Agrega el nuevo misil al juego
        game.onTick(400, "nuevoMisil", {nuevoMisil.mover(izquierda)})
        game.onTick(1, "nuevoMisil", {nuevoMisil.cambiarImagen()}); // Agrega movimiento al nuevo misil
    }

    method colisiono(personaje) {
        game.schedule(200, {self.pararJuegoYMostrarGameOver()})
    }

    method pararJuegoYMostrarGameOver() {
		game.removeVisual(botonPlay)
		game.removeVisual(fondoJuego)
		game.addVisual(fondoMenu)
		game.addVisual(gameOver)
		game.schedule(400,{game.stop()})
	}
}

class Token {
    var property position = game.at(9,7)
    const property imagenes = ["token.png","token1.png","token2.png","token3.png","token4.png","token5.png","token6.png","token7.png","token8.png","token9.png","token10.png"]
    var property imagenActualIndex = 0
    var property visible = true

    method image() {
        return if (visible) imagenes.get(imagenActualIndex) else null
    }

    method tipo() {
        return "Token"
    }

    method cambiarImagen() {
        imagenActualIndex = (imagenActualIndex + 1) % imagenes.size()
    }

    method mover(direccion) {
        var nuevaPosicion = direccion.siguiente(self.position()) 
        
        tablero.validarDentro(nuevaPosicion) // Validar el movimiento
        self.position(nuevaPosicion) // Actualizar la posición

        // Verifica si el misil llegó al borde izquierdo
        if (self.position().x() <= -1){ 
            game.removeVisual(self) // Elimina el token actual
            game.removeTickEvent(self) // Elimina el onTick
            game.schedule(30000, {self.reaparecer()})
            // Llama al método para reaparecer
        }
    }

    method reaparecer() {
        // Genera una nueva posición aleatoria en el eje Y
        var nuevaPosicionY = randomizer.anyY()
        // Crea un nuevo misil en la posición a la derecha
        const nuevoToken = new Token(position = game.at(12, nuevaPosicionY))
        game.addVisual(nuevoToken) // Agrega el nuevo misil al juego
        game.onTick(400, "nuevoToken", {nuevoToken.mover(izquierda)})
        game.onTick(1, "nuevoToken", {nuevoToken.cambiarImagen()}); // Agrega movimiento al nuevo misil
    }

    method colisiono(personaje) {
        self.desaparecer()
    }

    method desaparecer() {
        visible = false
        game.removeVisual(self)
    }

}
class Coin {
    var property position = game.at(9,3)
    const property imagenes = ["7.png","2.png","3.png","4.png","5.png","6.png"]
    var property imagenActualIndex = 0
    var property visible = true // Propiedad para saber si está visible

    method image() {
        return if (visible) imagenes.get(imagenActualIndex) else null
    }

    method tipo() {
        return "Coin"
    }

    method cambiarImagen() {
        imagenActualIndex = (imagenActualIndex + 1) % imagenes.size()
    }

    method mover(direccion) {
        var nuevaPosicion = direccion.siguiente(self.position()) 
        
        tablero.validarDentro(nuevaPosicion) // Validar el movimiento
        self.position(nuevaPosicion) // Actualizar la posición

        // Verifica si el misil llegó al borde izquierdo
        if (self.position().x() <= -1){ 
            game.removeVisual(self) // Elimina el coin actual
            game.removeTickEvent(self) // Elimina el onTick
            self.reaparecer()
            // Llama al método para reaparecer
        }
    }   

    method reaparecer() {
        // Genera una nueva posición aleatoria en el eje Y
        var nuevaPosicionY = randomizer.anyY()
        // Crea un nuevo misil en la posición a la derecha
        const nuevoCoin = new Coin(position = game.at(12, nuevaPosicionY))
        game.addVisual(nuevoCoin) // Agrega el nuevo misil al juego
        game.onTick(400, "nuevoCoin", {nuevoCoin.mover(izquierda)})
        game.onTick(1, "nuevoCoin", {nuevoCoin.cambiarImagen()}); // Agrega movimiento al nuevo misil
    }

    method colisiono(personaje) {
        self.desaparecer()
    }

    method desaparecer() {
        visible = false // Desactivar la visibilidad
        game.removeVisual(self) // Quitar visualmente el objeto
    }
}

object fondo {
    method position() = game.at(0,0)

    method image() {
        return "fondo123.png"
    }
}

object reloj {
    var segundos = 0

    method position() {
        return game.at(0, game.height() - 1 )
    }

    method text() {
        return segundos.toString()
    }

    method textColor() {
        return "FFFF00FF"
    }

    method tick() {
        segundos = (segundos + 1) % 1000
    }

    method colisiono(personaje) {

    }
}