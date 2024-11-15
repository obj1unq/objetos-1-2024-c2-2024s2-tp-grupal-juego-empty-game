// acá es para poner todos los managers y que no estén sueltos por ahí
import proyectiles.*
import posiciones.*
import juego.*
import extras.*
import personajes.personaje.*
import enemigos.*

object managerAcido {
    method acidoEnCon(pos, dmg) {
        const acidoNuevo = new Acido(position = pos)
        game.addVisual(acidoNuevo)
        managerVisual.resetearVisuales()
        acidoNuevo.daniar(dmg)
    }
}

object managerCrater {

    method explosionEnCon(pos,dmg) {
        tablero.alrededoresDe(pos).forEach({pos => self.aparecerCraterEn(pos,dmg)})
        managerVisual.resetearVisuales()
    }

    method aparecerCraterEn(pos,dmg) {
        const craterNuevo = new Crater(position=pos)
        game.addVisual(craterNuevo)
        craterNuevo.daniar(dmg)
    }
}

object managerVisual {
    const visuales = #{}

    method agregarVisual(visual) { 
        game.addVisual(visual)
        visuales.add(visual)
    }

    method removerVisual(visual) {
        game.removeVisual(visual)
        visuales.remove(visual)
    }

    method resetearVisuales() {
        visuales.forEach({v => v.resetearVisual()})
    }
}

object managerItems {
    //const property drops = #{}

    method posicionRandom() {
        return (game.at(0.randomUpTo(game.width() - 1), 0.randomUpTo(game.height() - 2)))
    }

    method spawnearCura(numero) {
        const nuevaCura = managerCuras.cura(numero, self.posicionRandom())
        managerVisual.agregarVisual(nuevaCura)
        //drops.add(nuevaCura)
    }

    method spawnearOro(numero) {
        const oroNuevo = managerMonedas.monedas(numero, self.posicionRandom())
        managerVisual.agregarVisual(oroNuevo)
        //drops.add(oroNuevo)
    }

    method spawnearMunicionRandom() {
        const nuevaMunicion = new Balas(position = self.posicionRandom())
        managerVisual.agregarVisual(nuevaMunicion)
        //drops.add(nuevaMunicion)
    }

    method spawnearMunicionEn(posicion) {
        const nuevaMunicion = new Balas(position = posicion)
        managerVisual.agregarVisual(nuevaMunicion)
        //drops.add(nuevaMunicion)
    }
}

object managerCuras {
    const vida = [20, 40, 80]

    method cura(numero, position) {
        return new Cura(image = personaje.visualHealth(numero)
                , vidaDada = self.vida(numero), position = position)
    }

    method vida(numero) {
        return vida.get(numero - 1)
    }
}

object managerMonedas {
    const oro = [10, 30, 50]
    
    method monedas(numero, position) {
        return new Oro(image = "oro" + numero + ".png",
                valor = self.oro(numero), position = position)
    }

    method oro(numero) {
        return oro.get(numero - 1)
    }
}

object managerZombie {
    const property zombies = #{}
    var contador = 0

    method quitarZ(zombie) {
        zombies.remove(zombie)
    }

    method spawnearZ(zombie) {
        zombies.add(zombie)
        managerVisual.agregarVisual(zombie)
        zombie.persecucion()
    }

    method activarODesactivarGeneracionAleatoria() {
        if(contador.even()) {
            contador += 1
            game.onTick(3000, "generarZombiesRandom", {self.generarZombieAleatorio(randomizadorZombies.posicionAleatoria())})
        } else {
            contador += 1
            game.removeTickEvent("generarZombiesRandom")
        }
    }

    method generarZombieAleatorio(posicion) {
        const zombieNuevo = randomizadorZombies.randomizarZombie(posicion)
        zombies.add(zombieNuevo)
        managerVisual.agregarVisual(zombieNuevo)
        zombieNuevo.persecucion()
    }

    method posTieneZombie(pos) {
        return (zombies.any({zom => zom.position() == pos}))
    }
}