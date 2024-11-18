import cabezal.*
import wollok.game.*
import objetos.*
import characters.*
import edificios.*


object mapa {
    const property aliados = #{}
    const property enemigos = #{}
    const property objetos = #{}
    const property edificios = #{}
    var property nivelActual = nivel1 

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

    method quitarEnemigo(enemigo) {
        enemigos.remove(enemigo)
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

    method agregarEdificio(edificio) {
      edificios.add(edificio)
    }

    method stats() {
        aliados.forEach( {aliado => aliado.stats() } )
        enemigos.forEach( {enemigo => enemigo.stats() } )
        edificios.forEach( {edificio => edificio.stats() } )
    }

}



class Nivel {

    method tableroNivel() {
        return mapa.nivelActual().tablero()
    }

    method inicializar() {
        self.dibujar()
        constructorOros.instanciarOros(4)
	    constructorPiedras.instanciarPiedra(3)
	    constructorHuevos.instanciarHuevos(1)
        castillo.inicializar()
        mapa.inicializarAliadosVivos()
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
        self.removerTodasLasVisuales()
        self.tableroNivel().clear()
    }

    method removerTodasLasVisuales() {
        game.allVisuals().forEach({v => game.removeVisual(v)})
    }

}

object nivel1 inherits Nivel {
    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,ce],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [m,m,m,m,m,m,_,_,_,_,_,_,_,_,_,m,m,m,m,m],
     [_,_,_,_,_,m,m,m,_,_,_,_,_,_,_,m,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,m,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse()

    override method siguiente() {
        mapa.nivelActual(nivel2)
    }

}

object nivel2 inherits Nivel {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,ce],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [m,m,m,m,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,m,m,m,m,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,m,m,m,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,m,m,m,m,m,m],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
    ].reverse()

    override method siguiente() {
        mapa.nivelActual(nivel3)
    }

}

object nivel3 inherits Nivel {

    const property tablero = 
    [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,ce],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [m,m,m,m,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,m,m,m,m,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],     
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,m,c,m,_,_,_,_,_,_,_,_,_,_,m,m,m,m,m,m],
     [_,m,m,m,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]         
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