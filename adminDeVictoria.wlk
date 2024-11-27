import mapaObjetos.*
import wollok.game.*
import objetosRecepcion.*


object adminWinCon {
    const cajaFondos = caja

    method ganar() {
        game.addVisual(youWin)
        game.schedule(3000, {game.stop()})
    }

    method perder() {
        if(caja.plata() <= caja.objetivo()) {
            game.addVisual(youLose)
            game.schedule(3000, {game.stop()})
        }
        
    }
}