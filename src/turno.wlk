import characters.*
import map.*
import cabezal.*
object turno {

    var property turno = 1



    method image() {
        return "turno-" + turno + ".png"
    }

    method pasarABatalla() {
        cabezal.setModo(cabezalBatalla)
    }

    method sumarTurno() {
        turno += 1
    }

    method terminarTurno() {
        mapa.nivelActual().gastarTurno()
        self.sumarTurno()
        cabezal.recargarMovimiento()
        cabezal.recargarAtaque()
    }
  
}