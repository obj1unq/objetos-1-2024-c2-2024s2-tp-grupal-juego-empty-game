import wollok.game.*
import personaje.*

object enemigo1 {
    var position = game.at(0,0); 
	const property esArma = false
	
	method position() {
		return game.at(0,0)
        //return (game.at(personaje.position().x() + 1, personaje.position().y()))
	}

	method image() { //image() se calcula a cada frame al igual que position(), si no entendí mal
		return "enemigo1" + self.estado() + ".png"
	}

	method estado() {
		return ""
	}
}