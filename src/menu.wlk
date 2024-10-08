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
    generadorDeObjetos.construirMisil()
    generadorDeObjetos.construirMisil()
	  generadorDeObjetos.constuirMoneda()
    generadorDeObjetos.constuirMoneda()
    generadorDeObjetos.construirToken()
    generadorDeObjetos.construirReloj()
    generadorDeObjetos.gravedad()


	  keyboard.up().onPressDo({barry.volar()})
	  keyboard.w().onPressDo({barry.volar()})
	
    // Colisiones
    game.onCollideDo(barry, {cosa => cosa.colisiono(barry)})  
  }
}