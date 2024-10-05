import wollok.game.*

object arriba {
	method siguiente(position) {
		return position.up(1)
	}
}

object abajo {
	method siguiente(position) {
		return position.down(1)
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

object limite {

	method validarLimites(position) {
		if (not self.estaDentro(position)) {
			self.error("No puede mover fuera del límite.")
		}
	}

	method estaDentro(position) {
		return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 1)
	}

	method validarBloqueo(position) {
		if (game.getObjectsIn(position).any({obj => not obj.esAtravesable() and not obj.esDesplazable()}))
			self.error("No puedo mover. Un objeto bloquea.")
	}

	method validarAtravesables(position) {
		if (game.getObjectsIn(position).any({obj => not obj.esAtravesable()}))
			self.error("No puedo mover. Ya un objeto en esa posición.")
	}
}