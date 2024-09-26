import randomizer.*
import paleta.*
import personaje.*

class Arma {
    var property estaEquipada = false
    const position = game.at(randomizer.posicionesRandomArmas().head(),randomizer.posicionesRandomArmas().last() )
    method nivel() {
        return 1.randomUpTo(3).round()
    }


    method serEquipada() {
      self.estaEquipada(true) 
    }

    method danio()  
    method durabilidad() 


    method position() {
        return position
    }

 /*   method position() {
        return game.at(randomizer.posicionesRandomArmas().head(),randomizer.posicionesRandomArmas().last() )
    }*/

    // El pj colsiona con el arma y la mete en la bolsa()
    method colsiono(pj){
        pj.equiparArma(self)
    }



    method image() 

    method imagenParaPersonaje()



}

object espada2 inherits Arma() {

    override method durabilidad() {
        return 100.randomUpTo(130).round()
    }

    override method danio() {
        return 35 + self.nivel() * 10
    }

    override method image() {
        return "espada2small.png"
    }

    override method imagenParaPersonaje() {
        return "ConEspada"
    }

    // Para test
    method text(){ return self.durabilidad().toString() + "\n Nivel: " + self.nivel().toString()}
    method textColor() = paleta.rojo()


}

object arcoYFlecha2 inherits Arma() {

    override method durabilidad() {
        return 130.randomUpTo(150).round()
    }

    override method danio() {
        return 20 + self.nivel() * 10
    }
        override method image() {
        return "arcoYFlecha1small.png"
    }

    override method imagenParaPersonaje() {
        return "ConArcoYFlecha"
    }

    // Para test
    method text(){ return self.durabilidad().toString() + "\n Nivel: " + self.nivel().toString()}
    method textColor() = paleta.rojo()

}

object martillo inherits Arma() {

    override method durabilidad() {
        return 50.randomUpTo(90).round()
    }

    override method danio() {
        return 80 + self.nivel() * 10
    }

    override method image() {
        return "martilloDeGuerra1small.png"
    }

    override method imagenParaPersonaje() {
        return "ConMartilloDeGuerra"
    }

    // Para test
    method text(){ return self.durabilidad().toString() + "\n Nivel: " + self.nivel().toString()}
    method textColor() = paleta.rojo()

}
