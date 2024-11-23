import characters.*
import map.*
import cabezal.*
object turno {

    method pasarABatalla() {
        cabezal.setModo(cabezalBatalla)
    }

    method terminarTurno() {
        mapa.nivelActual().gastarTurno()
        cabezal.recargarMovimiento()
        cabezal.recargarAtaque()
    }
  
}