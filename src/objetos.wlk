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
    const property cantidad = 40 
  
    override method recogerObjeto() {
        castillo.guardarOro(cantidad)
        super()
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
    const property image = "piedra.png"
    const property cantidad = 1
  
    override method recogerObjeto() {
        castillo.guardarPiedra(cantidad)
        super()
    }
}

object constructorPiedras {

    method construirPiedra(position) {
        return new Piedra(position = position)
    }


    method instanciarPiedra(cantidad) {
        if (cantidad > 0) {
            const oro = self.construirPiedra(randomizer.emptyPosition())
            game.addVisual(oro)
            mapa.agregarObjeto(oro)
            self.instanciarPiedra(cantidad - 1)
        }
    }
}

class Huevo inherits Objeto {
    const property image = "huevoDragon.png"
    const property cantidad = 1


  
    override method recogerObjeto() {
        castillo.guardarHuevo(cantidad)
        super()
    }
}

object constructorHuevos {

    method construirHuevo(position) {
        return new Huevo(position = position)
    }


    method instanciarHuevos(cantidad) {
        if (cantidad > 0) {
            const oro = self.construirHuevo(randomizer.emptyPosition())
            game.addVisual(oro)
            mapa.agregarObjeto(oro)
            self.instanciarHuevos(cantidad - 1)
        }
    }
}
