import wollok.game.*
import tablero.*
import cosas.*
import posiciones.*
import reloj.*


object auto{
 
    var property position = game.at(0,0)
    var property image = "autoHaciaArriba.png"
   // const objetosARecoger = [termo, yerba, bizcochitos, dispenser, agua, manzanita, mate]

    method mover(direccion){
        const nuevaDireccion = direccion.siguiente(position)
        tablero.validarMovimiento(nuevaDireccion)
        self.validarAtravesables(nuevaDireccion)
        reloj.validarContinuarJuego()

        position = nuevaDireccion
        image = direccion.imagen()
    

    }

    method haySolido(_position) {
		return game.getObjectsIn(_position).any({cosa => cosa.solida()})
	}

    method validarAtravesables(_position) {
		if (self.haySolido(_position)) {
			tablero.error("No puedo ir ahí")
		}
	}
 
    method agarrarObjeto() {
      self.validarAgarrar()
      const objeto = game.colliders(self).find({objeto => objeto.esAgarrable()})
      objeto.cosaALaBarra()

     // self.verSiGane()
    }

    // method verSiGane(){
    //   if (self.recogiTodosLosObjetos()){
    //     game.addVisual(ganeJuego)

    //     game.stop()
    //   }
    // }

    // method recogiTodosLosObjetos(){
    //   return objetosARecoger.all({objeto => objeto.recogido()})
    // }


    method validarAgarrar(){
      if(not self.hayObjeto()){
        self.error("No nada para agarrar!") 
      }  
    }

    method hayObjeto(){
      return game.colliders(self).any({objeto => objeto.esAgarrable()})
    }
    
}

object ganeJuego{
  const property position = game.at(0,0)
  const property image = "ganeJuego.png"

}
