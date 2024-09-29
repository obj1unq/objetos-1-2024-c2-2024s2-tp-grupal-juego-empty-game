import armas.*
import extras.*
import wollok.game.*


object randomizer {

	method randomDe1Hasta(numero) {
		return 1.randomUpTo(numero).round()
	}

	method armaRandom() {
		return #{espada2, martillo, arcoYFlecha2}.anyOne()
	}

    // Esto es una prueba no tomar encerio pero estoy desesperado.
    method armaRamdon2() {
        const espada3 = new Arma3(durabilidadDe = 100, durabilidadHasta = 130, danho = 35, image = "espada2small", imagePj = "personajeConEspada-32Bits")
        const arcoYFlecha3 = new Arma3(durabilidadDe = 130, durabilidadHasta = 150, danho = 20, image = "arcoYFlecha1small",imagePj = "personajeConEspada-32Bits")
        const martillo3 = new Arma3(durabilidadDe = 50, durabilidadHasta = 90, danho = 80, image = "martilloDeGuerra1small", imagePj = "personajeConEspada-32Bits")

        return #{espada3, arcoYFlecha3, martillo3}.anyOne()
    }
		
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
	}

	method posicionesRandomArmas() {
		const listaDePosicionesArma = [[6,3], [6,7], [4,7], [2,7],[3,10], [11,9], [11,6]]
		return listaDePosicionesArma.get(0.randomUpTo(listaDePosicionesArma.size() - 1))
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	
}