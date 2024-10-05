import wollok.game.*
import objetos.*

object nivel {
    const property botones = #{new Boton(position=game.at(2,2))}
    const property cajas = #{new Caja(position=game.at(1,3))}
    const property muros = #{new Muro(position=game.at(2,3))}

    method addVisual() {
        botones.forEach({boton => game.addVisual(boton)})
        cajas.forEach({caja => game.addVisual(caja)})
        muros.forEach({muro => game.addVisual(muro)})
    }
}