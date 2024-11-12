object arriba {

	method imagen(name) {
		return // name + "" + ".arriba.png"
	}

	method moverse(namePosition) {
	  return namePosition.up(1)
	}
}

object abajo {

	method imagen(name) {
		return //name + "" + ".abajo.png"
	}
	
	method moverse(namePosition) {
	  return namePosition.down(1)
	}
}

object izquierda {

	method imagen(name) {
		return //name + "" + ".izquierda.png"
	}

	method moverse(namePosition) {
	  return namePosition.left(1)
	}
}

object derecha {

	method imagen(name) {
		return //name + "" + ".derecha.png"
	}

	method moverse(namePosition) {
	  return namePosition.right(1)
	}
}

/*
se necesita:
-(nombre).derecha.png
-(nombre).izquierda.png
-(nombre).arriba.png
-(nombre).abajo.png
*/