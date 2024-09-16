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