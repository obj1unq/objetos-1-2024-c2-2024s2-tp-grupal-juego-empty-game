import wollok.game.*
import auto.*
import cosas.*

object reloj {

    var property segundos = 10

    var property  position = game.at(0, 9 )
    

    method text() {
        return if(segundos>0){
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

    method tick() {
        segundos = (segundos - 1) % 1000

    }


    method solida() {
		return false
	}


}