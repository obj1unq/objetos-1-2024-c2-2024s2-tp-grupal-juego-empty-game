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
}

class C1 inherits Calle (){

    override method image() = "esquina_1.png"
}

class C2 inherits Calle (){

    override method image() = "esquina_2.png"
}

class C3 inherits Calle (){

    override method image() = "esquina_3.png"
}

class C4 inherits Calle (){

    override method image() = "esquina_4.png"
}

class C5 inherits Calle (){

    override method image() = "calleHorizontal.png"
}

class C6 inherits Calle (){

    override method image() = "calleVertical.png"
}

class Vereda {
    const property position 

    method solida() {
		return true
	}

    method image()
}

class V1 inherits Vereda (){

    override method image() = "vIzqArriba.png"
}

class V2 inherits Vereda (){

    override method image() = "vHorArriba.png"
}

class V3 inherits Vereda (){

    override method image() = "vDerArriba.png"
}

class V4 inherits Vereda (){

    override method image() = "vVertDer.png"
}

class V5 inherits Vereda (){

    override method image() = "vDerAbajo.png"
}

class V6 inherits Vereda (){

    override method image() = "vHorAbajo.png"
}

class V7 inherits Vereda (){

    override method image() = "vIzqAbajo.png"
}

class V8 inherits Vereda (){

    override method image() = "vVerticalIzq.png"
}