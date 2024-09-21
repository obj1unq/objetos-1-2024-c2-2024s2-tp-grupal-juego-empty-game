import extras.*
import wollok.game.*

object randomizer {

	method randomDe1Hasta(numero) {
		return 1.randomUpTo(numero).round()
	}

	method armaRandom() {
		const rnd = 0.randomUpTo(2).round()
		return if (rnd==2) espada else if(rnd==1) arcoYFlecha else martilloDeGuerra
	}
		
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
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