import wollok.game.*
import posiciones.*

object personaje {
    var property position = game.at(3,3)
    var property image = "avatar.png"

    method mover(direccion) {
        const siguiente = direccion.siguiente(self.position())
        self.validarMovimiento(siguiente)
        self.desplazarSiHayCaja(direccion)
        position = siguiente
    }

    method validarMovimiento(posicion) {
        limite.validarLimites(posicion)
        limite.validarBloqueo(posicion)
    }

    method desplazarSiHayCaja(direccion) {
        const objetosEnSiguientePos = game.getObjectsIn(direccion.siguiente(self.position()))
        if (objetosEnSiguientePos.any({obj => obj.esDesplazable()})) {
            const caja = objetosEnSiguientePos.find({obj => obj.esDesplazable()})
            caja.desplazar(direccion) 
        }
    }
}