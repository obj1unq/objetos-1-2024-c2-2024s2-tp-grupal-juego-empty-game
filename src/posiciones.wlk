import wollok.game.*
object arriba {
	method siguiente(position) {
		return position.up(1)
	}
}

object abajo {
	method siguiente(position) {
		return position.down(0.18)
	}	
}

object izquierda {
	method siguiente(position) {
		return position.left(1)
	}
}

object derecha {
	method siguiente(position) {
		return position.right(1)
	}
}

object tablero {
	method validarDentro(position) {
		if (not self.estaDentro(position)) {
			self.error("No puedo moverme fuera del tablero")
		}
	}

	method estaDentro(position) {
		return position.x().between(-1, game.width()) and position.y().between(0, game.height() - 1)
	}
}