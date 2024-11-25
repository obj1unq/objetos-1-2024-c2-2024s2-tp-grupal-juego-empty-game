import cabezal.*
import wollok.game.*
import objetos.*
import characters.*
import edificios.*
import textos.*
import turno.*
import direcciones.*
import pantallas.*


object mapa {
    const property aliados = #{}
    const property enemigos = #{}
    const property objetos = #{}
    var property nivelActual = pantallaInicio 

    method inicioJuego() {
        self.removerTodasLasVisuales()
        self.iniciarControles()
        nivelActual.inicializar()
    }

    method removerTodasLasVisuales() {
        game.allVisuals().forEach({v => game.removeVisual(v)})
    }

    method iniciarControles() {
    keyboard.left().onPressDo({cabezal.mover(izquierda)})
    keyboard.right().onPressDo({cabezal.mover(derecha)})
    keyboard.up().onPressDo({cabezal.mover(arriba)})
    keyboard.down().onPressDo({cabezal.mover(abajo)})
	keyboard.num1().onPressDo({castillo.spawn(new Comandante(team = aliado))})
	keyboard.num2().onPressDo({castillo.spawn(new Soldado (team=aliado))})
	keyboard.num3().onPressDo({castillo.spawn(new Arquero(team = aliado))})
	keyboard.num4().onPressDo({castillo.spawn(new Mago (team = aliado))})
	keyboard.num5().onPressDo({castillo.spawn(new Golem (team= aliado))})
	keyboard.num6().onPressDo({castillo.spawn(new Dragon (team = aliado))})
	keyboard.a().onPressDo({cabezal.accionar()})
	keyboard.s().onPressDo({cabezal.cancelar()})
	keyboard.t().onPressDo({turno.pasarABatalla()})
	keyboard.r().onPressDo({turno.terminarTurno()})
    }

    method validarSiEstaDentro(posicion) {
        return if (not self.estaDentro(posicion)) {
             cabezal.error("No me puedo mover a esa posición ya que esta fuera de los limites!")
        }
    }

    method estaDentro(posicion) {
		return posicion.x().between(0, game.width() - 1) and posicion.y().between(0, game.height() - 1)
	}

    method validarSiHayObjetoSolido(posicion) {
        return if (self.hayObjetoSolido(posicion)) {
            cabezal.error("No me puedo mover a esa posición ya que hay un objeto solido")
        }
    }

    method hayObjetoSolido(posicion) {
        return self.hayObjetoEn(posicion) && self.objetoEn(posicion).solido()
    }

    method validarSiHayAlgunPersonaje(posicion) {
        return if (self.hayUnidadAca(posicion)) {
            cabezal.error("No puedo mover la seleccion actual a esa posición ya que hay otro personaje")
        }
    }

    method validarMoverACastilloEnemigo(posicion) {
        return if (self.estaElCastilloEnemigoAca(posicion) && not self.todosLosEnemigosEstanVencidos()) {
            cabezal.error("¡No podes tomar el castillo enemigo hasta derrotar a todos los enemigos!")
        }
    }

    method estaElCastilloEnemigoAca(posicion) {
        return castilloEnemigo.position() == posicion
    }

    method todosLosEnemigosEstanVencidos() {
        return enemigos.isEmpty()
    }

    method quitar(personaje) {
        if (self.esUnEnemigo(personaje)) {
            enemigos.remove(personaje)
        } else {
            aliados.remove(personaje)
        }
    }

    method esUnEnemigo(personaje) {
        return enemigos.contains(personaje)
    }

    method agregarAliado(aliado){
     aliados.add(aliado)
    }

    method agregarEnemigo(enemigo){
        enemigos.add(enemigo)
    }

    method aliadosEn(posicion) {
        return aliados.find({pj => pj.position() == posicion})
    }

    method enemigosEn(posicion) {
        return enemigos.find({pj => pj.position() == posicion})
    }

    method validarSeleccionAliada(posicion) {
        if (not self.hayAliadosEn(posicion)){
            cabezal.error("No hay nada para seleccionar!")
        }
    }

    method hayAliadosEn(posicion) {
        return aliados.any({aliado => aliado.position() == posicion})
    }

    method hayEnemigosEn(posicion){
        return enemigos.any({enemigo => enemigo.position() == posicion})
    }

    method hayUnidadAca(posicion){
        return self.hayAliadosEn(posicion) || self.hayEnemigosEn(posicion)
    }
    method validarSeleccionEnemiga(posicion) {
        if (not self.hayEnemigosEn(posicion)){
            cabezal.error("No hay nada para seleccionar!")
        }
    }

    method agregarObjeto(objeto) {
        objetos.add(objeto)
    }

    method eliminarObjeto(objeto) {
        objetos.remove(objeto)
    } 

    method objetoEn(posicion) {
        return objetos.find({o => o.position() == posicion})
    }

    method hayObjetoEn(posicion) {
        return objetos.any({o => o.position() == posicion})
    }

    method inicializarAliadosVivos() {
        if (not self.todosLosAliadosEstanVencidos()) {
            aliados.forEach({a => a.inicializarEnNivel()})
        }
    }

    method todosLosAliadosEstanVencidos() {
        return aliados.isEmpty()
    }

    method siguienteNivel() {
        self.objetos().clear()
        nivelActual.limpiarTablero()
        nivelActual.siguiente()
        nivelActual.inicializar()
    }


    method stats() {
        aliados.forEach( {aliado => aliado.stats() } )
        enemigos.forEach( {enemigo => enemigo.stats() } )
        castillo.stats()
        game.say(cabezal, "Turnos restantes: " + nivelActual.turnosDelNivel())
    }

}

object hud{
    var property position = null

    
    method image(){
        return "hud6.png"
    }

    method inicializar() {
        position = game.at(15, 0)
        game.addVisual(self)
        self.inicializarTextos()
    }

    method inicializarTextos() {
    game.addVisual(cantidadTurnos)
	game.addVisual(textoReservas)
	game.addVisual(statsPjActual)
	game.addVisual(probabilidades)
	game.addVisual(probabilidadesDragonGolem)
	game.addVisual(probabilidadesComandSol)
	game.addVisual(probabilidadesArqMag)
    }

}

class Nivel {

    var property turnosDelNivel

    method tableroNivel() {
        return mapa.nivelActual().tablero()
    }

    method inicializar() {
        self.dibujar()
        constructorOros.instanciarOros(2)
	    constructorPiedras.instanciarPiedra(1)
        castillo.inicializar()
        cabezal.inicializar()
        mapa.inicializarAliadosVivos()
        hud.inicializar()
    }


    method dibujar() {
        game.height(self.tableroNivel().size())
        game.width(self.tableroNivel().get(0).size())

        (0..game.width() - 1).forEach({ x =>
            (0..game.height() -1).forEach({y =>
            self.tableroNivel().get(y).get(x).dibujarEn(game.at(x,y))
            })
        })
    }

    method siguiente()

    method limpiarTablero() {
        mapa.removerTodasLasVisuales()
        self.tableroNivel().clear()
    }



    method gastarTurno() {
        turnosDelNivel -= 1
    }

}


object pantallaInicio inherits Nivel(turnosDelNivel = 1) {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],    
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],    
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],   
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],  
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], 
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [in,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]
     ].reverse()

    override method inicializar() {
        self.ejecutarPantalla()
        self.siguiente()
    }

    method ejecutarPantalla() {
        self.dibujar()
        keyboard.enter().onPressDo({mapa.inicioJuego()})
    }


    override method siguiente() {
        mapa.nivelActual(nivel1)
    }
}
object nivel1 inherits Nivel(turnosDelNivel = 15) {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,ce,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,ae,_,coe,_,_,_,_,_,_,_,_],    
     [_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],    
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],   
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],  
     [_,_,_,_,_,_,_,_,o,m,m,m,m,m,m,_,_,_,_,_,_,_,_], 
     [_,_,_,_,_,_,m,m,se,m,_,_,_,_,_,_,_,_,_,_,_,_,_], 
     [m,m,m,m,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [me,o,ae,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,o,_,_,_,_,_,_,_,_,_,_,_,_,_]
     ].reverse()

    override method siguiente() {
        mapa.nivelActual(nivel2)
    }

}

object nivel2 inherits Nivel(turnosDelNivel = 25) {

    const property tablero = 
    [[_,_,_,m,_,_,_,_,_,_,_,_,_,me,ce,_,_,_,_,_,_,_,_],
     [_,o,_,m,_,_,_,_,_,_,_,_,_,coe,_,_,_,_,_,_,_,_,_],    
     [_,p,_,se,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_],    
     [_,p,_,ae,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],   
     [m,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],  
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], 
     [_,_,_,_,_,_,_,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_], 
     [_,o,_,_,_,_,_,_,_,_,_,_,_,m,m,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,m,h,_,_,_,_,_,_,_,_],
     [_,_,_,o,_,coe,_,o,_,_,_,_,_,m,ge,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]
     ].reverse()

    override method siguiente() {
        mapa.nivelActual(nivel3)
    }

}

object nivel3 inherits Nivel(turnosDelNivel = 32) {

    const property tablero = 
    [[_,_,p,_,m,_,_,_,_,_,_,_,_,ge,ce,_,_,_,_,_,_,_,_],
     [_,o,se,_,se,_,_,_,o,_,_,_,_,de,ae,_,_,_,_,_,_,_,_],    
     [_,_,p,_,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],    
     [m,m,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],   
     [_,_,_,_,_,_,_,_,_,_,_,_,m,m,m,_,_,_,_,_,_,_,_],  
     [ae,c,_,_,_,_,_,_,_,_,_,_,o,ae,_,_,_,_,_,_,_,_,_], 
     [h,me,_,_,_,_,_,_,m,m,m,m,_,_,_,_,_,_,_,_,_,_,_], 
     [ae,c,_,_,o,me,_,_,_,_,_,_,_,_,c,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,o,_,_,_,_,c,_,_,_,_,_,_,_,_],
     [m,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,m,_,_,_,_,_,_,_,o,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,coe,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]
     ].reverse()

    override method siguiente() {
        // Ver si queda vacio o el siguiente podria ser un nivel que muestre la pantalla final del juego y tire el game stop
    }
}


object _ {
    method dibujarEn(position) {
    }
    
}


object m {
    method dibujarEn(position) {
        const muro = new Muro(position = position)
        game.addVisual(muro)
        mapa.agregarObjeto(muro)
    }
}

object c {
    method dibujarEn(position) {
        const casa = new CasaMedieval(position = position)
        game.addVisual(casa)
        mapa.agregarObjeto(casa)
    }
}

object ce {
    method dibujarEn(position) {
        castilloEnemigo.position(position)
        game.addVisual(castilloEnemigo)
        
    }
}

object h {
    method dibujarEn(position) {
        const huevo = new Huevo(position = position)
        game.addVisual(huevo)
        mapa.agregarObjeto(huevo)
    }
}

object p {
    method dibujarEn(position) {
        const piedra = new Piedra(position = position)
        game.addVisual(piedra)
        mapa.agregarObjeto(piedra)
    }
}

object o {
    method dibujarEn(position) {
        const oro = new Oro(position = position)
        game.addVisual(oro)
        mapa.agregarObjeto(oro)
    }
}

object coe {
    method dibujarEn(position) {
        const comandanteEnemigo = new Comandante(team = enemigo, position = position)
        game.addVisual(comandanteEnemigo)
        mapa.agregarEnemigo(comandanteEnemigo)
    }
}

object me {
    method dibujarEn(position) {
        const magoEnemigo = new Mago(team = enemigo, position = position)
        game.addVisual(magoEnemigo)
        mapa.agregarEnemigo(magoEnemigo)
    }
}

object se {
    method dibujarEn(position) {
        const soldadoEnemigo = new Soldado(team = enemigo, position = position)
        game.addVisual(soldadoEnemigo)
        mapa.agregarEnemigo(soldadoEnemigo)
    }
}

object ae {
    method dibujarEn(position) {
        const arqueroEnemigo = new Arquero(team = enemigo, position = position)
        game.addVisual(arqueroEnemigo)
        mapa.agregarEnemigo(arqueroEnemigo)
    }
}

object ge {
    method dibujarEn(position) {
        const golemEnemigo = new Golem(team = enemigo, position = position)
        game.addVisual(golemEnemigo)
        mapa.agregarEnemigo(golemEnemigo)
    }
}

object de {
    method dibujarEn(position) {
        const dragonEnemigo = new Dragon(team = enemigo, position = position)
        game.addVisual(dragonEnemigo)
        mapa.agregarEnemigo(dragonEnemigo)
    }
}

object in {
    method dibujarEn(position) {
        inicio.position(position)
        game.addVisual(inicio)
    }
}