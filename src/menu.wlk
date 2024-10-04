import wollok.game.*
import barry.*
import posiciones.*
import extras.*
import randomizer.*

object fondoMenu {
	method image() {
    return "menu.png"
  }

  method position() = game.at(0,0)
}

object fondoJuego {
  method image() {
    return "fondo123.png"
  }

  method position() = game.at(0,0)
}

object botonPlay {
    method image() {
      return "play.png"
    }

    method position() = game.at(4,1)
}

object gameOver {
  method image() {
    return "gameover.png"
  }

  method position() = game.at(4,0)
}
class Menu {
  var property juegoIniciado = false
  
  method init() {
    game.title("jetpackjoyride")
	  game.height(10)
	  game.width(12)
	  game.cellSize(50)
        
    game.addVisual(fondoMenu) // Mostrar el fondo del menú
    game.addVisual(botonPlay)
    // Configurar la acción para iniciar el juego cuando se presiona "Enter"
    keyboard.enter().onPressDo({
    self.startGame() // Iniciar el juego al presionar "Enter"
    })
  }

  method startGame() {
    self.juegoIniciado(true) // Marcar el juego como iniciado
    game.removeVisual(fondoMenu) // Limpiar visuales del menú
    game.removeVisual(botonPlay)
    // Llamar a la función de inicialización del juego
    self.iniciarJuego()
  }

  method iniciarJuego() {
	  game.addVisual(fondoJuego)
	  game.addVisual(reloj)
	  game.addVisual(barry)

	  // Crear instancias de clases
	  const misil1 = new Misil(position = game.at(12, randomizer.anyY()))
	  const misil2 = new Misil(position = game.at(11, randomizer.anyY()))
	  const coin1 = new Coin(position = game.at(12, randomizer.anyY()))
	  const coin2 = new Coin(position = game.at(11, randomizer.anyY()))
	  const token1 = new Token(position = game.at(12, randomizer.anyY()))

	  // Añadir visuales
	  game.addVisual(misil1)
	  game.addVisual(misil2)
	  game.addVisual(coin1)
	  game.addVisual(coin2)
	  game.addVisual(token1)

	  keyboard.up().onPressDo({barry.volar()})
	  keyboard.w().onPressDo({barry.volar()})
	
    // Colisiones
    game.onCollideDo(barry, {cosa => cosa.colisiono(barry)})

	  game.onTick(1000, "reloj", {reloj.tick()})
	  game.onTick(400, "misil1", {misil1.mover(izquierda)})
	  game.onTick(400, "misil2", {misil2.mover(izquierda)})
	  game.onTick(1, "coin1", {coin1.cambiarImagen()})
	  game.onTick(1, "coin2", {coin2.cambiarImagen()})
	  game.onTick(600, "coin1", {coin1.mover(izquierda)})
	  game.onTick(600, "coin2", {coin2.mover(izquierda)})
	  game.onTick(100, "token1", {token1.cambiarImagen()})
	  game.onTick(600, "token1", {token1.mover(izquierda)})
	  game.onTick(1, "misil1", {misil1.cambiarImagen()})
	  game.onTick(1, "misil2", {misil2.cambiarImagen()})
	  game.onTick(50, "gravedad", {barry.caer()})  
  }
}