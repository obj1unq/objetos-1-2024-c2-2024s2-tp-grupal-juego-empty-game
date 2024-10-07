import wollok.game.*
import personajes.personaje.*
import enemigos.*
import extras.*
import posiciones.*
import sonidos.*

object juego {

    method visuals() {
        game.addVisual(timer)
        game.addVisual(personaje)
        game.addVisual(puntosDeVida)
        game.addVisual(cargador)
        //game.addVisual(cura1)
        game.addVisual(balas)
        //game.addVisual(oro1)
        //game.addVisual(oro2)
        //game.addVisual(oro3)
        //game.addVisual(muro)
        game.addVisual(oroObtenido)
    }

    method ataque() {

        keyboard.left().onPressDo({personaje.ataque(izquierda)})
        keyboard.right().onPressDo({personaje.ataque(derecha)})
        keyboard.up().onPressDo({personaje.ataque(arriba)})
        keyboard.down().onPressDo({personaje.ataque(abajo)})

    }

    method movimiento() {
        keyboard.w().onPressDo({personaje.mover(arriba)})
	    keyboard.a().onPressDo({personaje.mover(izquierda)})
	    keyboard.s().onPressDo({personaje.mover(abajo)})
	    keyboard.d().onPressDo({personaje.mover(derecha)})

    }

    method tablero() {
        game.title("desvariados") 
        game.width(17)
        game.height(17)
        game.cellSize(45)
        game.ground("pisonuevo-stage1.png")

        // para testear las clases vamos a colocar teclas para hacer aparecer cada una
        // mas adelante sus spawns van a estar decididos por otros eventos y no estas teclas
        keyboard.z().onPressDo({managerZombie.spawnearZombieComun()})
        keyboard.c().onPressDo({managerItems.spawnearCura1()})
        keyboard.o().onPressDo({managerItems.spawnearOro1()})

        game.onTick(1000, "timer", {timer.tick()})
    }


/*
    method sonido() {
        keyboard.p().onPressDo({sape.play()})
        const rain = game.sound("echo-in-the-night.mp3")
        rain.shouldLoop(true)
        rain.volume(0.3)
        game.schedule(005, { sonidoFondo.play()} )
    }
*/


    method colisiones() {
        game.onCollideDo(personaje, {item => item.colisionPj()})
    }


/*
    method pausa() {
        keyboard.space().onPressDo({self.pausarTodo()})
    }

    method pausarTodo() {
        var presionado = 0

        if (presionado == 0) {
            presionado = 1
            personaje.pausarse()
            game.removeTickEvent("persecucion")
            game.removeTickEvent("timer")
        } else {
            presionado = 0
            game.onTick(1000, "timer", {timer.tick()})
            game.onTick(800, "persecucion", {zombie.perseguirAPersonaje()})
            personaje.vivo()
        }
    }
*/
}