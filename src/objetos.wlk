import wollok.game.*
import direcciones.*
import map.*
import characters.*
import edificios.*

class Objeto {
    const property position

    method recogerObjeto() {
        game.removeVisual(self)
        mapa.eliminarObjeto(self)
    }


}
class Oro inherits Objeto {
    const property image = "pepitaDeOro.png"
    const property cantidad = 20 
  
    override method recogerObjeto() {
        castillo.guardarOro(cantidad)
        super()
    }

    method solido() {
        return false
    }

} 

object constructorOros {

    method construirOro(position) {
        return new Oro(position = position)
    }


    method instanciarOros(cantidad) {
        if (cantidad > 0) {
            const oro = self.construirOro(randomizer.emptyPosition())
            game.addVisual(oro)
            mapa.agregarObjeto(oro)
            self.instanciarOros(cantidad - 1)
        }
    }
}

class Piedra inherits Objeto {
    const property image = "pi.png"
    const property cantidad = 1
  
    override method recogerObjeto() {
        castillo.guardarPiedra(cantidad)
        super()
    }

    method solido() {
        return false
    }
}

object constructorPiedras {

    method construirPiedra(position) {
        return new Piedra(position = position)
    }


    method instanciarPiedra(cantidad) {
        if (cantidad > 0) {
            const piedra = self.construirPiedra(randomizer.emptyPosition())
            game.addVisual(piedra)
            mapa.agregarObjeto(piedra)
            self.instanciarPiedra(cantidad - 1)
        }
    }
}

class Huevo inherits Objeto {
    const property image = "huevo.png"
    const property cantidad = 1


  
    override method recogerObjeto() {
        castillo.guardarHuevo(cantidad)
        super()
    }

    method solido() {
        return false
    }
}

class Muro {

    const property position

    method image() {
        return "muronew.png"
    }

    method solido() {
		return true
	}

}

class CasaMedieval {
    const property position

    method image() {
        return "casam.png"
    }

    method solido() {
		return true
	}
}

object castilloEnemigo {
    var property position = game.center()

    method image() {
        return "castilloenem.png"
    }

    method solido() {
        return false
    }
}

