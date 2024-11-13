import personajes.personaje.*
import wollok.game.*
import juego.*
import posiciones.*
import enemigos.*

class Proyectil {

    var property danio
    var property image
    var property position

    method mover(direccion) {
	    position = direccion.siguientePosicion(position)
	}

    method nombreEvento() {
        return "evento" + self.identity()
    }

    method disparoHacia(direccion)

    method sigueOHayZombie(direccion) {
        const zombiesHacia = managerZombie.zombies().filter({zombie => self.sigueOEsta(direccion, zombie)}) // reotcasr
        return (not(zombiesHacia.isEmpty()))
    }

    method sigueOEsta(direccion, zombie) {
        return zombie.position() == direccion.siguientePosicion(position) or zombie.position() == position
    }

    method impacto(dir) {
        game.removeTickEvent(self.nombreEvento())
        game.schedule(100,{game.removeVisual(self)})
    }

    method validarViajeProyectil(direccion) {
        if (self.sigueOHayZombie(direccion)) {
            const zombiesHacia = managerZombie.zombies().filter({zombie => self.sigueOEsta(direccion, zombie)})
            zombiesHacia.forEach({zombie => zombie.herir(danio)})
            self.impacto(direccion)
        }
        else if (not(tablero.estaDentro(direccion.siguientePosicion(position)))) {
            self.impacto(direccion)
        }
    }

    method traspasable() {
        return true
    }
}

class Bala inherits Proyectil(danio=10) {


    method nuevoViaje(dir) { 
        game.onTick(120, self.nombreEvento() , {self.disparoHacia(dir)})
    }

    method imagenEnNumDir(num,direccion) {
       return "bala-" + num.toString() + "-" + direccion.toString() + ".png"
    }

    override method disparoHacia(direccion) {
        self.validarViajeProyectil(direccion)
        self.mover(direccion)
    }

    override method impacto(dir) {
        self.image("bala-impacto-" + dir.toString() + ".png")
        super(dir)
    }
}

class BolaDeFuego inherits Proyectil(danio=20) {

    method nuevoViaje(dir) { 
        game.onTick(150, self.nombreEvento() , {self.disparoHacia(dir)})
    }

    method imagenEnNumDir(num,direccion) {
        return "bola-" + num.toString() + "-" + direccion.toString() + ".png"
    }

    override method disparoHacia(direccion) {
        self.validarViajeProyectil(direccion)
        self.animacionBola(direccion)
    }

    method animacionBola(direccion) {
        self.image(self.imagenEnNumDir(2, direccion))
        game.schedule(20,{self.imagenEnNumDir(3, direccion)})
        game.schedule(50,{self.imagenEnNumDir(4, direccion)})
        game.schedule(80,{self.mover(direccion)})
        game.schedule(100,{self.imagenEnNumDir(1, direccion)})
    }

    override method impacto(dir) {
        self.image("bola-impacto-" + dir.toString() + ".png")
        super(dir)
    } 
}
object managerCrater {

    method jugador() {
        return juego.jugador()
    }

    method explosionEnCon(pos,dmg) {
        tablero.alrededoresDe(pos).forEach({pos => self.aparecerCraterEn(pos,dmg)})
    }

    method aparecerCraterEn(pos,dmg) {
        const craterNuevo = new Crater(position=pos)
        game.addVisual(craterNuevo)
        craterNuevo.daniar(dmg,self.jugador())
    }
}
class Crater {
    var property image = "tanqueimpacto.png"
    const property position

    method daniar(dmg,jugador) {
        const colisiones = managerZombie.zombies().filter({z => z.position() == position})
        if (jugador.position() == position) {
            colisiones.add(jugador)
        }
        colisiones.forEach({c => c.herir(dmg)})
        game.schedule(2000,{game.removeVisual(self)})
    }

    method traspasable() {
        return true
    }
}

object managerAcido {
    method jugador() {
        return juego.jugador()
    }
    
    method acidoEnCon(pos, dmg) {
        const acidoNuevo = new Acido(position = pos)
        game.addVisual(acidoNuevo)
        acidoNuevo.daniar(dmg,self.jugador())
    }
}

class Acido {
    var property image = "arbusto.png"
    const property position

    method daniar(dmg,jugador) {
        game.onTick(500, self.identidad(), {self.colisiones(jugador).forEach({c => c.herir(dmg)})})
        game.schedule(3550, {game.removeTickEvent(self.identidad())})
        game.schedule(4000,{game.removeVisual(self)})
    }

    method colisiones(jugador) {
        const colisiones = managerZombie.zombies().filter({z => z.position() == position})
        if (jugador.position() == position) {
            colisiones.add(jugador)
        }
        return colisiones
    }

    method identidad() {
        return self.identity().toString()
    }

    method traspasable() {
        return true
    }
}