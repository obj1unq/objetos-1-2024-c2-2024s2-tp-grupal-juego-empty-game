import wollok.game.*
import auto.*
import cosas.*
import inicio.*

object reloj {

    var property segundos = 30

    var property  position = game.at(0, 9 )
    

    method text() {
        return if(self.sigueEnTiempo()){
                    segundos.toString()
                }else{
                    ""
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

        if (not inicio.estado().seguirMostrando()){

            segundos = (segundos - 1) % 1000
        }
    
    }

    method validarContinuarJuego(){
        if (not self.sigueEnTiempo()){
            game.addVisual(finDeJuego)

            //game.stop() //NO MUESTRA EL CARTEL DE "FIN DE JUEGO"

	        game.onTick(1000, "fin de juego", {game.stop()})

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