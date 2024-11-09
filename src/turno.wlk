import characters.*
import map.*
import cabezal.*
object turno {

    method pasarABatalla() {
        cabezal.setModo(cabezalBatalla)
    }

    method terminarTurno() {
        mapa.aliados().forEach({aliado => aliado.recargarMovimiento()})
        mapa.aliados().forEach({aliado => aliado.recargarAtaque()})
    }
  
}