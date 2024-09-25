import randomizer.*


class Arma {
    var property estaEquipada = false
    const position = game.at(randomizer.posicionesRandomArmas().head(),randomizer.posicionesRandomArmas().last() )
    method nivel() {
        return 1.randomUpTo(3).round()
    }

    method durabilidad() 

    method serEquipada() {
      self.estaEquipada(true) 
    }

    method danio() 

    method position() {
        return position
    }

 /*   method position() {
        return game.at(randomizer.posicionesRandomArmas().head(),randomizer.posicionesRandomArmas().last() )
    }*/

    method image() 

    method imagenParaPersonaje()
}

object espada inherits Armas() {

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
}

object arcoYFlecha inherits Armas() {

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
}

object martillo inherits Armas() {

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
}
