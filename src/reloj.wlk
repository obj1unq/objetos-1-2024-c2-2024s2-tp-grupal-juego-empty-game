import wollok.game.*
import auto.*
import cosas.*

object reloj {

    var property segundos = 30

    var property  position = game.at(0, 9 )
    

    method text() {
        return if(self.sigueEnTiempo()){
                    segundos.toString()
                }else{
                    position = game.at(1,9)
                    "FIN DE JUEGO"
                    //HACER QUE DEJE DE PODER MOVERSE EL AUTO
                }
    }

    method textColor() {
        return "FFFF00FF"
    }
    method sigueEnTiempo(){
        return segundos>0
    }

    method tick() {
        self.validarContinuarJuego()
        segundos = (segundos - 1) % 1000

    }

    method validarContinuarJuego(){
        if (not self.sigueEnTiempo()){
            game.addVisual(finDeJuego)
            
            game.stop()

	        //game.onTick(1000, "fin de juego", {game.stop()})

        }
    }


    method solida() {
		return false
	}


}

object finDeJuego{
  var property position = game.at(0,0)
  var property image = "finDelJuego.png"
}