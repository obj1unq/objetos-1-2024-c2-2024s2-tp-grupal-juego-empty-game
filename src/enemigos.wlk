import wollok.game.*
import personaje.*
import posiciones.*
import pelea.*
import extras.*

//PREGUNTAR sobre como hacer un objeto que herencie una clase que está
//dentro de una superclase --> esqueleto

class Enemigo {
    var position
    var vida
    const objetivoADestruir = personaje
    var acumuladorDeTurnos = 0
    const danioBase 

    method position() {
        return position
    }

    method image() 
    method estado() 

    method colisiono(personaje) {
     self.combate() 
    }
    
    method vida() {
        return vida
    }

    method combate() {
        combate.entidadAtacando(self)   //Hace saber al combate que él(enemigo/self) será quien empieza
        combate.iniciarCombate()    //prepara toda el hud del combate y la info necesaria

        position = position.right(1)    //se posiciona una celda a la derecha del personaje
        game.say(self, "Ah! Pelea!")    // Avisa . Despues se va a quitar

        combate.cambiarTurnoA(self) //Empieza el combate
    }
      
    method atacarPre() {
      self.atacar()
    }

    method atacar() {
        objetivoADestruir.recibirDanho(self.danio()) //FUTURO: Hacer las habilidades del enemigo y hacerlo clase
        combate.cambiarTurnoA(objetivoADestruir)
        acumuladorDeTurnos+=1
    }

    method danio()
    method habilidad()
    
    method recibirDanho(cantidad){
        vida = vida - cantidad
    }

    method mover() 

    method morir() {
        game.removeVisual(self)
    }

      
}

class OjoVolador inherits Enemigo {
    
   override  method image() { //image() se calcula a cada frame al igual que position(), si no entendí mal
		return "ojito32a.png"
        
	}

	override method estado() {
		return ojoSinArma //como, de momento, tiene un solo estado, es un poco raro. Tendrá mas sentido si tiene más estados (como el pj)
	}

    //MOVIMIENTO

    method distanciaEnEjeX() {
        return (objetivoADestruir.position().x() - position.x())
    }

    method distanciaEnEjeY() {
        return (objetivoADestruir.position().y() - position.y())
    }

   override method mover() { 
        if (self.distanciaEnEjeX().abs() > self.distanciaEnEjeY().abs()) {
            if(self.distanciaEnEjeX() > 0) {
                position = derecha.siguiente(position)
            } else {
                position = izquierda.siguiente(position)
            }
        } else if (self.distanciaEnEjeY().abs() > self.distanciaEnEjeX().abs()) {
            if(self.distanciaEnEjeY() > 0) {
                position = arriba.siguiente(position)
            } else {
                position = abajo.siguiente(position)
            }
        }
    }

    // COMBATE/PELEA
    
    override method atacar() {
        if(acumuladorDeTurnos < 1) {
            objetivoADestruir.recibirDanho(danioBase)
        } else {
            self.habilidad()
        }
    }
   
    override method danio() {
        
    }

    override method habilidad() {
        combate.cambiarTurnoA(self)
    }
}

class Esqueleto inherits Enemigo {

    override method image() {
        return "esqueleto" + self.estado().imagenParaPersonaje() + "-32Bits.png"
    }

    override method estado() {
        return esqueletoSinArma
    }

    override method mover() {
           self.encontrarObjetivo()
    }

    method encontrarObjetivo() {
        self.validarEncontrar()
        position = objetivoADestruir.position()
        self.combate()
    }

    method validarEncontrar() {
        if (!self.hayObjetivoEnVision()) {
            self.error("")
        }
    }

    method hayObjetivoEnVision() {
        return objetivoADestruir.position().x().between(3, 7) && objetivoADestruir.position().y() == self.position().y()
    }
    override method danio() {
        if(acumuladorDeTurnos < 4) {
          return danioBase //43
        } else {
            return self.habilidad()
        }
    }

    override method habilidad() {
        return
        acumuladorDeTurnos = 0
    }
}

class Goblin inherits Enemigo {
       
    override method image() {
        return "enemigo1" + self.estado().imagenParaPersonaje() + "-32Bits.png"
    }

    override method estado() {
        return goblinSinArma
    }

    override method mover() {
           
    }

    override method danio() {
        if(acumuladorDeTurnos < 2) {
          return danioBase //37
        } else {
            return self.habilidad()
        }
    }

    override method habilidad() {
        return danioBase * 3
        acumuladorDeTurnos = 0
    }
}

object fabricaDeOjos {

    method nuevoEnemigo() {
        const ojo = new OjoVolador(position = game.at(14,9) , vida = 150, danioBase = 20)
        dungeon.enemigos().add(ojo)
        return ojo
  }
}

object fabricaDeEsqueleto {

    method nuevoEnemigo() {
        const esqueletoIzq = new Esqueleto(position = game.at(3,10) , vida = 200, danioBase = 43)
        dungeon.enemigos().add(esqueletoIzq)
        return esqueletoIzq
  }
}

object fabricaDeGoblin {
    method nuevoEnemigo() {
        const goblin = new Goblin(position = game.at(15, 14), vida = 95, danioBase = 37)
        dungeon.enemigos().add(goblin)
        return goblin
    }
}

/*object fabricaDeEsqueleto1 {

    method nuevoEnemigo() {
        const esqueletoDer = new Esqueleto(position = game.at(26,13) , vida = 200)
        dungeon.enemigos().add(esqueletoDer)
        return esqueletoDer
  }
}*/


object ojoSinArma {

    method imagenParaPersonaje() {
        return ""
    }
}

object esqueletoSinArma {

    method imagenParaPersonaje() {
      return ""
    }
}

object goblinSinArma {

    method imagenParaPersonaje() {
        return ""
    }
}

