import wollok.game.*
import auto.*
import tablero.*
import randomizador.*
import barraSuperior.*

class Calle {
    const property position 
    

    method solida() {
		return false
	}

    method image() 

    method esAgarrable(){
        return false
    }
}

class Esquina1 inherits Calle (){ //

    override method image() = "esquina-1.png"
}

class Esquina2 inherits Calle (){

    override method image() = "esquina-2.png"
}

class Esquina3 inherits Calle (){

    override method image() = "esquina-3.png"
}

class Esquina4 inherits Calle (){

    override method image() = "esquina-4.png"
}

class CalleHorizontal inherits Calle (){

    override method image() = "calle-horizontal.png"
}

class CalleVertical inherits Calle (){

    override method image() = "calle-vertical.png"
}

class Vereda {
    const property position 

    method solida() {
		return true
	}

    method image() = "vereda.png"

    method esAgarrable(){
        return false
    }
}

class Casa{
    const property position 

    method solida() {
		return true
	}

    method image()

    method esAgarrable(){
        return false
    }
}

class Casa1 inherits Casa{
    override method image() = "casa1.png"
}

class Casa2 inherits Casa{
    override method image() = "casa2.png"
}

class Casa3 inherits Casa{
    override method image() = "casa3.png"
}