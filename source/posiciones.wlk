import wollok.game.*

object arriba {

    method siguientePosicion(position) {
        return position.up(1)
    }
 
}

object izquierda {
   
    method siguientePosicion(position) {
        return position.left(1)
    }

}

object abajo {

    method siguientePosicion(position) {
        return position.down(1)
    }

}

object derecha {

    method siguientePosicion(position) {
        return position.right(1)
    }
    
}

object tablero {

	method validarDentro(position) {
		if (not self.estaDentro(position)) {
			self.error("No puedo moverme fuera del tablero")}
	}

	method estaDentro(position) {
		return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 1)
	}

}