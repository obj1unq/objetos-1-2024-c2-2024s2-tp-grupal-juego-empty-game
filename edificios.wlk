import wollok.game.*
import map.*

object castillo {
    const property position = game.origin()

    method image(){
        return "castillo.png"
    }

    method spawn(unidad){
        self.checkSpawn()
        unidad.position(self.position())
        game.addVisual(unidad)


    }

    method checkSpawn(){
        if (not mapa.hayUnidadAca(self.position())){
            self.error("El castillo esta ocupado!")
        }
    }
}