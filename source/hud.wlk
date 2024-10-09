import wollok.game.*
import personajes.personaje.*

//---------------------------------Timer---------------------------------------

object timer {

    var segundos = 0
    var minutos  = 0

    method position() {
        return game.at(8, game.height() - 1 )
    }

    method text() {
        return minutos.toString() +":"+ segundos.toString()
    }

    method textColor() {
        return "FFFFFF"
    }

    method tick() {
        if(segundos < 60){
            segundos += 1
        }else{
            minutos += 1
            segundos = 0
            segundos += 1
        }

    }

    method colisionPj() {}

}
//----------------------------------------------HUD-----------------------------
object barra{
    var property image =  "blacklong.png"
    var property position = game.at(0, 16)

    //game.addVisual("black.png")
}
//----------------------------------BARRA DE VIDA-----------------------------

object puntosDeVida {

    var property image =  "barravida-100.png"
    var property position = game.at(0, 16)

    method actualizar(){
        self.image("barravida-"+personaje.vida()+".png")
    }

    method colisionPj() {}
}

//----------------------------------------------MUNICION-----------------------------

object cargador {
    var property position = game.at(6, 16)

    method text() {
        return personaje.municion().toString()
    }

    method colisionPj() {}

    method textColor() {
        return "90EE90"
    }
}


//----------------------------------------------ORO-----------------------------
object oroObtenido {

    method position() {
        return game.at(12, game.height() - 1 )
    }

    method text() {
        return personaje.oro().toString()
    }

    method colisionPj() {}

    method textColor() {
        return "D4AF37"
    }
}


//----------------------------------------------energia(?-----------------------------
