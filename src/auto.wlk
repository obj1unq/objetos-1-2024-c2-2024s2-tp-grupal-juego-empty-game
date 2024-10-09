import wollok.game.*
import tablero.*
import cosas.*
import posiciones.*
import reloj.*

object auto{
    var property position = game.at(0,0)
    var property image = "autoHaciaArriba.png"
    const objetosARecoger = [termo, yerba, bizcochitos, dispenser, agua, manzanita, mate]

    method mover(direccion){
        const nuevaDireccion = direccion.siguiente(position)
        tablero.validarMovimiento(nuevaDireccion)
        reloj.validarContinuarJuego()

        position = nuevaDireccion
        image = direccion.imagen()


    }


    method agarrarObjeto() {
      self.validarAgarrar()
      const objeto = game.uniqueCollider(self)
      objeto.objetoALaBarra()

      self.verSiGane()
    }

    method verSiGane(){
      if (self.recogiTodosLosObjetos()){
        game.addVisual(ganeJuego)

        game.stop()
      }
    }

    method recogiTodosLosObjetos(){
      return objetosARecoger.all({objeto => objeto.recogido()})
    }


    method validarAgarrar(){
      if(not self.hayObjeto()){
        self.error("") 
      }  
    }

    method hayObjeto(){
      return game.colliders(self).size() > 0
    }




    
}

object ganeJuego{
  const property position = game.at(0,0)
  const property image = "ganeJuego.png"
}
