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
    const tipo = ""
    var durabilidad = 1
    //¿no importa que no tenga el método position? porque parece que el objeto es aceptado por wollok aún sin tenerlo

    method durabilidad() {
        return durabilidad
    }

    method atacar() {
        if (tipo=="espada") {
            //ataque espada
        } else if (tipo=="arco") {
            //ataque arco
        } else { //caso cetro mágico
            //ataque cetro mágico
        }
        durabilidad = durabilidad - 20
    }
}

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