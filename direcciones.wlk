import wollok.game.*

class Direccion {

    method siguiente(posicion) {
        return self.siguiente(posicion, 1)
    }

    method siguiente (posicion, rango)
}

object arriba inherits Direccion {
    override method siguiente(direccion, rango) {
        return direccion.up(rango)
    }
}

object abajo inherits Direccion {
    override method siguiente(direccion, rango) {
        return direccion.down(rango)
    }
}

object izquierda inherits Direccion {
    override method siguiente(direccion, rango) {
        return direccion.left(rango)
    }
}

object derecha inherits Direccion {
    override method siguiente(direccion, rango) {
        return direccion.right(rango)
    }
}

object noreste inherits Direccion   {
    override method siguiente(direccion, rango){
        return direccion.right(rango).up(rango)
    }
}

object noroeste inherits Direccion {
    override method siguiente(direccion, rango) {
        return direccion.left(rango).up(rango)
    }
}

object sudeste inherits Direccion {

    override method siguiente(direccion, rango) {
        return direccion.right(rango).down(rango)
    }
}
 

object sudoeste inherits Direccion {
    override method siguiente(direccion, rango) {
        return direccion.left(rango).down(rango)
    }
}

object direcciones {
    const property todas = #{arriba, abajo, izquierda, derecha, noroeste, noreste, sudeste, sudoeste}
    const property principales = #{arriba, abajo, izquierda, derecha}
}
