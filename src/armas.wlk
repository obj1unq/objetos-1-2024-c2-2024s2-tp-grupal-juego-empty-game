import randomizer.*
import paleta.*
import personaje.*


class Arma {
    var property estaEquipada = false
    const property position = game.at(randomizer.posicionesRandomArmas().head(),randomizer.posicionesRandomArmas().last() )
    const nivel = 1.randomUpTo(3).round() 

    method serEquipada() {
      self.estaEquipada(true) 
    }

    // El pj colsiona con el arma y la mete en la bolsa()
    method colisiono(personaje){
        personaje.equiparArma(self)
    }

    //se implementan en cada una de las subclases de tipos de arma (ya que en todas varía)
    method danho()
    method image() 
    method imagenParaPersonaje()
    method restarDurabilidad(cantidadRestada)
    method chequearDurabilidad()
    method habilidadEspecial()

}

class Espada inherits Arma {
    var property durabilidad = 100.randomUpTo(130).round() //porque es un dato cambiante que debe cambiar y no recalcularse cada vez.
    //y la declaramos acá porque si se declara en la superclase ya no le podemos dar valor inicial personalizado a menos que sea usando 
    //algún método

    override method restarDurabilidad(cantidadRestada) {
        durabilidad -= cantidadRestada
    }

    override method chequearDurabilidad() {
        if (self.durabilidad() <= 5) {
            personaje.armaActual(mano) //en realidad hay que fijarse si tiene otra y pasar esa al primero, y si hay tercera pasarla a 2do
            personaje.bolsa().remove(personaje.bolsa().head())
        } else {
            self.restarDurabilidad(5)
        }
    }

    override method danho() {
        return 35 + nivel * 3
    }

    override method image() {
        return "espadaGris-32Bits.png"
    }

    override method imagenParaPersonaje() {
        return "ConEspada"
    }

    override method habilidadEspecial() {
        return self.danho() * 2 //golpe critico RASGUÑO MORTALLLLL
    }

    // Para test
    method text(){ return "Durabilidad: " + self.durabilidad().toString() + "\nNivel: " + nivel.toString()}
    method textColor() = paleta.azul()


}

class ArcoYFlecha inherits Arma {
    var property durabilidad = 130.randomUpTo(150).round() //porque es un dato cambiante que debe cambiar y no recalcularse cada vez.
    //y la declaramos acá porque si se declara en la superclase ya no le podemos dar valor inicial personalizado a menos que sea usando 
    //algún método

    override method restarDurabilidad(cantidadRestada) {
        durabilidad -= (cantidadRestada * 2)
    }

    override method chequearDurabilidad() {
        if (self.durabilidad() <= 5) {
            personaje.armaActual(mano) 
            personaje.bolsa().remove(personaje.bolsa().head())
        } else {
            self.restarDurabilidad(5)
        }
    }

    override method danho() {
        return 20 + nivel * 3
    }
        override method image() {
        return "arcoYFlecha-32Bits.png"
    }

    override method imagenParaPersonaje() {
        return "ConArcoYFlecha"
    }

    // Para test
    method text(){ return "Durabilidad: " + self.durabilidad().toString() + "\nNivel: " + nivel.toString()}
    method textColor() = paleta.azul()

    override method habilidadEspecial() {
        return //veneno
    }
}

class MartilloDeGuerra inherits Arma {
    var property durabilidad = 50.randomUpTo(90).round() //porque es un dato cambiante que debe cambiar y no recalcularse cada vez.
    //y la declaramos acá porque si se declara en la superclase ya no le podemos dar valor inicial personalizado a menos que sea usando 
    //algún método

    override method restarDurabilidad(cantidadRestada) {
        durabilidad = durabilidad - (cantidadRestada / 2)
    }

    override method chequearDurabilidad() {
        if (self.durabilidad() <= 5) {
            personaje.armaActual(mano) //en realidad hay que fijarse si tiene otra y pasar esa al primero, y si hay tercera pasarla a 2do
            personaje.bolsa().remove(personaje.bolsa().head())
        } else {
            self.restarDurabilidad(5)
        }
    }

    override method danho() {
        return 80 + nivel * 3
    }

    override method image() {
        return "martilloDeGuerra-32Bits.png"
    }

    override method imagenParaPersonaje() {
        return "ConMartilloDeGuerra"
    }

    // Para test
    method text(){ return "Durabilidad: " + self.durabilidad().toString() + "\nNivel: " + nivel.toString()}
    method textColor() = paleta.azul()

    override method habilidadEspecial() {
        return //pierde turno enemigo
    }

}

object mano { //objeto especial (hay que trabajar con los efectos que causa porque noto efectos raros en la pelea al usar la mano)
    method danho() {
        return 5
    }

    method durabilidad() { }

    method chequearDurabilidad() { }

    method imagenParaPersonaje() { }
}

//FÁBRICAS (su única función es devolverme en nuevo objeto de la subclase de Arma a la que están ligadas. nos permiten crear armas random)

object fabricaEspada {

    method nuevaArma() {
        return new Espada()
    }

}

object fabricaArcoYFlecha {

    method nuevaArma() {
        return new ArcoYFlecha()
    }

}

object fabricaMartilloDeGuerra {

    method nuevaArma() {
        return new MartilloDeGuerra()
    }

}
