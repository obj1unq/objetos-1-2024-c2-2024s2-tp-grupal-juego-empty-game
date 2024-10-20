import wollok.game.*
import map.*

object castillo {
    const property position = game.at(1,0)

    method image(){
        return "castillo.png"
    }

    method spawn(unidad){
        self.checkSpawn()
        unidad.position(self.position())
        game.addVisual(unidad)
        mapa.agregarAliado(unidad)


    }

    method checkSpawn(){
        if (mapa.hayUnidadAca(self.position())){
            self.error("El castillo esta ocupado!")
        }
    }
}