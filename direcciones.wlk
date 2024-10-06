import wollok.game.*


object arriba {
    method siguiente(direccion) {
        return direccion.up(1)
    }
}

object abajo {
    method siguiente(direccion) {
        return direccion.down(1)
    }
}

object izquierda {
    method siguiente(direccion) {
        return direccion.left(1)
    }
}

object derecha {
    method siguiente(direccion) {
        return direccion.right(1)
    }
}