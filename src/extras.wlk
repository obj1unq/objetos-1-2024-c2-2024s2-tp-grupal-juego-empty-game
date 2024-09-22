import wollok.game.*
import personaje.*
import randomizer.*

//ARMA

class Arma {
    const property tipo = randomizer.armaRandom()
    var property durabilidad = randomizer.randomDe1Hasta(120)
    const property esArma = true
    var property estaEquipada = false
    var property position = game.at(7,3)

    method image() {
        return tipo.image()
    }

    method durabilidad() {
        return durabilidad
    }

    // Interaccon con jugador ( agarrar/equipar )
    method serEquipada(){
        self.estaEquipada(true)
        self.position(game.at(personaje.position().x() + 1, personaje.position().y()))
    }

    method position(){
        if(self.estaEquipada())
            return game.at(personaje.position().x() + 1, personaje.position().y())
        else {
            return position
        }
    }

    method atacar() {
        if (tipo==espada) {
            //todo aquello que involucre al ataque con espada que NO pueda hacerse polimórficamente (cosas visuales, x ej)
        } else if (tipo==arcoYFlecha) {
            //ataque arco
        } else { //caso cetro mágico
            //ataque cetro mágico
        }
        //se puede usar tipo.danho() para calcular el daño de forma polimórfica
        durabilidad = durabilidad - 20
    }
}

//tipos de arma

object arcoYFlecha {
    const property danho = 20

    method image() {
        return "arcoYFlecha1small.png"
    }
}

object espada {
    const property danho = 35

    method image() {
        return "espada2small.png"
    }
}

object martilloDeGuerra {
    const property danho = 50

    method image() {
        return "martilloDeGuerra1small.png"
    }
}

/*propuesta de idea: El personaje se encuentra con armas de forma random por la pantalla (habría que ver como randomizar que aparezcan
en el tablero). Las armas que se encuentra son objetos de tipo Arma, los cuales tienen los atributos tipo y durabilidad que también son 
randoms. Una cosa es que la durabilidad sería un int pero los tipos son objetos (espada, arcoYFlecha y cetroMagico). Estos objetos, por 
ahora, tienen el atributo danho (daño) que indica cuanto daño causa un ataque con esa arma.
Para mí, la durabilidad de las armas, si bien sería random, podría ser cualquier valor en un determinado rango en base al tipo del arma.
Las armas del tipo que más daño causa (cetro mágico) podría tener un rango de durabilidad de 40 a 100, las espadas, que hacen un poco menos
de daño, de 80 a 140, y el arco y flecha, que es el que menos daño hace, de 120 a 180 (por poner algún valor)
*/

//visuales del tablero

//Esto es para la visual en el tablero. Muestra los objetos que tiene actualmente el personaje (en realidad, por ahora solo muestra la cant)
object listaDeObjetos {
    const property esArma = false

    method position() {
		return game.at(9,9)
	}

	method image() { 
		return "listaDeObj" + self.estado() + ".png"
	}

    method estado() {
        if(personaje.bolsa().size()==3) {
            return "3"
        } else if (personaje.bolsa().size()==2) {
            return "2"
        } else if (personaje.bolsa().size()==1) {
            return "1"
        } else {
            return "0"
        }
    }

}

/*
object contadorDeMana {
    var numeroDePuntos = 3;
}
*/