import wollok.game.*
import personaje.*
import posiciones.*
import pelea.*

/*Tenemos que hacerlo clase pero yo no entendí :)*/

class Enemigo {
    var position
    var vida
    const objetivoADestruir = personaje

    method position(){
        return position
    }
    method image() 
    method estado() 
    method colisiono(personaje) {
     self.combate() 
    }
    method combate() {
        combate.entidadAtacando(self)   //Hace saber al combate que él(enemigo/self) será quien empieza
        combate.iniciarCombate()    //prepara toda el hud del combate y la info necesaria

        position = position.right(1)    //se posiciona una celda a la derecha del personaje
        game.say(self, "Ah! Pelea!")    // Avisa . Despues se va aquitar

        combate.cambiarTurnoA(self) //Empieza el combate
    }
      
    method atacarPre() {
      self.atacar()
    }

    method atacar()
    
     method recibirDanho(cantidad){
        vida = vida - cantidad
    }
    method mover() 

    method morir()
    method vida()
    
  
}

class OjoVolador inherits Enemigo {
	
    override method vida() {
      return vida
    }
   override  method image() { //image() se calcula a cada frame al igual que position(), si no entendí mal
		return "ojito32a.png"
        //return "enemigo1" + self.estado().imagenParaPersonaje() + "-32Bits.png"
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

   override  method mover() { 
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

    // cuando el pj colsiona con el enemigo, este incia el combate
   override method colisiono(personaje){
        self.combate()
    }

    // COMBATE/PELEA

    /*  - La posicion del enemigo es una celda a la derecha del personaje cuando empieza el combate.
        - Se le manda el enemigo a la barra de estado para saber con que enemigo esta peleando.
        - Aparece la barra de estado.
    */
   override method combate() {
        
        combate.entidadAtacando(self)   //Hace saber al combate que él(enemigo/self) será quien empieza
        combate.iniciarCombate()    //prepara toda el hud del combate y la info necesaria

        position = position.right(1)    //se posiciona una celda a la derecha del personaje
        game.say(self, "Ah! Pelea!")    // Avisa . Despues se va aquitar

        combate.cambiarTurnoA(self) //Empieza el combate
    }

    override method atacarPre() {
        //game.schedule(300, { self.atacar(self)}) // para que quede más lindo a lo visual, que tarde un toque en atacar, que no sea instantaneo (NO porque causa arrastre de daño)
        self.atacar()
    }

   override method atacar() {
        objetivoADestruir.recibirDanho(20) //FUTURO: Hacer las habilidades del enemigo y hacerlo clase
        combate.cambiarTurnoA(objetivoADestruir)
    }

   override method recibirDanho(cantidad){
        vida = vida - cantidad
    }

   override method morir() {
        /*Este método despues se va cambiar por un removeVisual o algo asi, esta así ahora para testear porque solo tenemos un enemigo.*/
        position = game.at(7,4)
        vida = 150
    }

}

class Esqueleto inherits Enemigo {
  override method image() {
    return "enemigo1" + self.estado().imagenParaPersonaje() + "-32Bits.png"
  }

  override method estado() {
        return esqueletoSinArma
  }

  override method mover() {
           
  }

   override method atacar() {
        objetivoADestruir.recibirDanho(43) //FUTURO: Hacer las habilidades del enemigo y hacerlo clase
        combate.cambiarTurnoA(objetivoADestruir)
    }

   override method recibirDanho(cantidad){
        vida = vida - cantidad
    }

   override method morir() {
        /*Este método despues se va cambiar por un removeVisual o algo asi, esta así ahora para testear porque solo tenemos un enemigo.*/
        position = game.at(7,4)
        vida = 150
    }

    override method vida() {
      return vida
    }
}

object fabricaDeOjos {
  method nuevoEnemigo() {
    return new OjoVolador(position = game.at(14,12) , vida = 150)
  }
}

object fabricaDeEsqueleto {
  method nuevoEnemigo() {
    return new Esqueleto(position = game.at(9,14) , vida = 200)
  }
}

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

