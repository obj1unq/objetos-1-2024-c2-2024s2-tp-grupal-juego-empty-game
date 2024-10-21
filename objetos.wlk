import wollok.game.*
import direcciones.*
import map.*
import characters.*

class Oro {
    const property image = "pepitaDeOro.png"

    method position(x, y) {
        return game.at(x, y)
    }

    method oroQueOtorga() {
        return 10
    }
} 

class Madera {
    const property image = "madera.png"
    
    method position(x, y) {
        return game.at(x, y)
    }

}