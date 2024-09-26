import wollok.game.*
import personaje.*
import randomizer.*
import paleta.*

//ARMA

/* Alguien más borrelo a mi me ansidad :)
class Arma {
    var property position = game.at(randomizer.posicionesRandomArmas().head(),randomizer.posicionesRandomArmas().last() )//randomizer.position()
    const property tipo = randomizer.armaRandom()
    const property esArma = true
    var property estaEquipada = false

    method image() {
        return tipo.image()
    }

    method imagenParaPersonaje() {
        return tipo.imagenParaPersonaje()
    }

    method durabilidad() {
        return tipo.durabilidad()
    }

    method durabilidadRestada(cantidadRestada) {
        tipo.durabilidadRestada(cantidadRestada)
    }

    method danho() {
       return tipo.danho() 
    }

    method chequearDurabilidad() {
        if (self.durabilidad() == 0) {
            personaje.armaActual(null)
            personaje.bolsa().remove(personaje.bolsa().head())
        } else {
            self.durabilidadRestada(5)
        }
    }


    // Interaccion con jugador ( agarrar/equipar )
    method serEquipada() {
        self.estaEquipada(true)
    }

    method position(){
        return position
    }

 //  method atacar() {
 //       if (tipo==espada) {
            //todo aquello que involucre al ataque con espada que NO pueda hacerse polimórficamente (cosas visuales, x ej)
 //       } else if (tipo==arcoYFlecha) {
            //ataque arco
 //       } else { //caso cetro mágico
            //ataque cetro mágico
 //       }
        //se puede usar tipo.danho() para calcular el daño de forma polimórfica
//        durabilidad = durabilidad - 20
//    }

    
   
}

//tipos de arma

object arcoYFlecha {
    var durabilidad = 130.randomUpTo(180).round() //devuelve un numero entre 130 y 180
    const danhoBase = 20
    const nivel = randomizer.randomDe1Hasta(3)

    method durabilidad() {
        return durabilidad
    }

    method durabilidadRestada(cantidadRestada) {
        durabilidad -= cantidadRestada
    }

    method danho() {
       return danhoBase + (nivel * 10) // depende el nivel que tenga el arma al ser encontrada se multiplica por 10 el nivel de esta para sumarselo al dañó base
    }    

    method image() {
        return "arcoYFlecha-32Bits.png"
    }

    method imagenParaPersonaje() {
        return "ConArcoYFlecha"
    }

    // Para Test
    method text(){ return durabilidad.toString() + "\n Nivel: " + nivel.toString()}
    method textColor() = paleta.rojo()

    // cuendo el pj colisiona con este arma se la equipa
    method colsiono(pj){
        pj.equiparArma(self)
    }
}

object espada {
    var property durabilidad = 100.randomUpTo(130).round()
    const danhoBase = 35
    const nivel = randomizer.randomDe1Hasta(3)

    method danho() {
      return  danhoBase + (nivel * 10) // depende el nivel que tenga el arma al ser encontrada se multiplica por 10 el nivel de esta para sumarselo al dañó base
    }

    method image() {
        return "espadaGris-32Bits.png"
    }

    method imagenParaPersonaje() {
        return "ConEspada"
    }

    // Para test
    method text(){ return durabilidad.toString() + "\n Nivel: " + nivel.toString()}
    method textColor() = paleta.rojo()

    // cuendo el pj colisiona con este arma se la equipa
    method colsiono(pj){
        pj.equiparArma(self)
    }

}

object martilloDeGuerra {
    var property durabilidad = 80.randomUpTo(100).round()
    const danhoBase = 50
    const nivel = randomizer.randomDe1Hasta(3)
    
    method danho() {
       return danhoBase + (nivel * 10) // depende el nivel que tenga el arma al ser encontrada se multiplica por 10 el nivel de esta para sumarselo al dañó base
    }    

    method image() {
        return "martilloDeGuerra-32Bits.png"
    }

    method imagenParaPersonaje() {
        return "ConMartilloDeGuerra"
    }

    // Para test
    method text(){ return durabilidad.toString() + "\n Nivel: " + nivel.toString()}
    method textColor() = paleta.rojo()

    // cuendo el pj colisiona con este arma se la equipa
    method colsiono(pj){
        pj.equiparArma(self)
    }
}


/*propuesta de idea: El personaje se encuentra con armas de forma random por la pantalla (habría que ver como randomizar que aparezcan
en el tablero). Las armas que se encuentra son objetos de tipo Arma, los cuales tienen los atributos tipo y durabilidad que también son 
randoms. Una cosa es que la durabilidad sería un int pero los tipos son objetos (espada, arcoYFlecha y cetroMagico). Estos objetos, por 
ahora, tienen el atributo danho (daño) que indica cuanto daño causa un ataque con esa arma.
Para mí, la durabilidad de las armas, si bien sería random, podría ser cualquier valor en un determinado rango en base al tipo del arma.
Las armas del tipo que más daño causa (cetro mágico) podría tener un rango de durabilidad de 40 a 100, las espadas, que hacen un poco menos
de daño, de 80 a 140, y el arco y flecha, que es el que menos daño hace, de 120 a 180 (por poner algún valor)
*/

//visuales del tablero

//Esto es para la visual en el tablero. Muestra los objetos que tiene actualmente el personaje (en realidad, por ahora solo muestra la cant)
object listaDeObjetos {
    const property esArma = false

    method position() {
		return game.at(15,15)
	}

	method image() { 
		return "listaDeObj" + self.estado() + "-32Bits.png"
	}

    method estado() {
        if(personaje.bolsa().size()==3) {
            return "3"
        } else if (personaje.bolsa().size()==2) {
            return "2"
        } else if (personaje.bolsa().size()==1) {
            return "1"
        } else {
            return "0"
        }
    }

    method text() {return personaje.armaActual()}
    method textColor() = paleta.rojo()

}

object spawn {

    method spawnArma() {
        return arma1= randomizer.armaRandom() 
    }

}