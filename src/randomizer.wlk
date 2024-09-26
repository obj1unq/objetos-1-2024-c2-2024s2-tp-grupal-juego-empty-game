import armas.*
import extras.*
import wollok.game.*


object randomizer {

	method randomDe1Hasta(numero) {
		return 1.randomUpTo(numero).round()
	}

	method armaRandom() {
		return [espada, arcoYFlecha, martilloDeGuerra].anyOne()
	}
		
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
	}

	method posicionesRandomArmas() {
		const listaDePosicionesArma = [[6,3], [6,7], [4,7], [2,7],[3,10], [11,9], [11,6]]
		return listaDePosicionesArma.get(0.randomUpTo(listaDePosicionesArma.size() - 1))
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	
}