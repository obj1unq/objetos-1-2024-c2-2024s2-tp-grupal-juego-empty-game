import wollok.game.*
import map.*
import characters.*
import objetos.*


object castillo {
    const property position = game.at(1,0)
    var property oroEnReserva = 40
    var property piedrasEnReserva = 2
    var property huevosEnReserva = 0

    method image(){
        return "castillo.png"
    }

    method guardarOro(cantidad) {
        oroEnReserva += cantidad
    }

    method guardarPiedra(cantidad) {
        piedrasEnReserva += cantidad
    }

    method guardarHuevo(cantidad) {
        huevosEnReserva += cantidad
    }

    method spawn(unidad){
        self.checkSpawn(unidad)
        unidad.position(self.position())
        game.addVisual(unidad)
        mapa.agregarAliado(unidad)
        unidad.efectosEnRecursosSpawn()

    }


    method checkSpawn(unidad){
        if (mapa.hayUnidadAca(self.position())){
            self.error("El castillo esta ocupado!")
        } else if (not (oroEnReserva >= unidad.valor()) || not unidad.condicionParaSpawn()) {  // Con que no cumpla una condicion ya entra al error
            self.error ("No dispones de los recursos suficientes para spawnear la unidad!")
        }
    }
}

class Casa {

    var property position

    method curarUnidad(){
        mapa.aliadosEn(self.position())
    }
}