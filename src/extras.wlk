import wollok.game.*
import pepita.*

object silvestre {

    //para silvestre, pepita no es pepita, sino que es simplemente una
    //presa. Es const porque la referencia es constante (no se la va
    //a cambiar por una referencia a otra cosa)
    const presa = pepita
    //como no hace falta inicializarlo en una cierta celda, sino que solo
    //imita la posición del otro, no hace falta que sea un atributo
    //postcálculo antes que precálculo (se puede deducir/calcular)
    method position() {
        return game.at(presa.position().x().max(3), 0)
    }

    method image() {
        return "silvestre.png"
    }

}

object nido {

    method position() {
        return game.at(7,8)
    }

    method image() {
        return "nido.png"
    }

}

//cositas nuevas

class Arma {
    const property tipo = espada
    var durabilidad = 1
    //¿no importa que no tenga el método position? porque parece que el objeto es aceptado por wollok aún sin tenerlo

    method durabilidad() {
        return durabilidad
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
}

object espada {
    const property danho = 35
}

object cetroMagico {
    const property danho = 50
}

/*propuesta de idea: El personaje se encuentra con armas de forma random por la pantalla (habría que ver como randomizar que aparezcan
en el tablero). Las armas que se encuentra son objetos de tipo Arma, los cuales tienen los atributos tipo y durabilidad que también son 
randoms. Una cosa es que la durabilidad sería un int pero los tipos son objetos (espada, arcoYFlecha y cetroMagico). Estos objetos, por 
ahora, tienen el atributo danho (daño) que indica cuanto daño causa un ataque con esa arma.
Para mí, la durabilidad de las armas, si bien sería random, podría ser cualquier valor en un determinado rango en base al tipo del arma.
Las armas del tipo que más daño causa (cetro mágico) podría tener un rango de durabilidad de 40 a 100, las espadas, que hacen un poco menos
de daño, de 80 a 140, y el arco y flecha, que es el que menos daño hace, de 120 a 180 (por poner algún valor)
*/

//Esto es para la visual en el tablero. Muestra los objetos que tiene actualmente el personaje (en realidad, por ahora solo muestra la cant)
object listaDeObjetos {

    method position() {
		return game.at(9,9)
	}

	method image() { 
		return "listaDeObj" + self.estado() + ".png"
	}

    method estado() {
        if(pepita.bolsa().size()==3) {
            return "3"
        } else if (pepita.bolsa().size()==2) {
            return "2"
        } else if (pepita.bolsa().size()==1) {
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