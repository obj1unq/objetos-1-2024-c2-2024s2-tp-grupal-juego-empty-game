import characters.*
import map.*
import cabezal.*
object turno {

    method pasarABatalla() {
    cabezal.modoBatalla()
    }

    method terminarTurno() {
        mapa.aliados.forEach({aliado => aliado.recargarMovimiento()})
    }
  
}