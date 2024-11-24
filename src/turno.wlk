import characters.*
import map.*
import cabezal.*
import wollok.game.*
import textos.*

object turno {

    method pasarABatalla() {
        cabezal.setModo(cabezalBatalla)
    }


    method terminarTurno() {
        mapa.nivelActual().gastarTurno()
        cabezal.recargarMovimiento()
        cabezal.recargarAtaque()
        cabezal.cancelar()
    }
  
}