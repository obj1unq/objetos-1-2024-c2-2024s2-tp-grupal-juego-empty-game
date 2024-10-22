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

    override method image() = "esquina_1.png"
}

class Esquina2 inherits Calle (){

    override method image() = "esquina_2.png"
}

class Esquina3 inherits Calle (){

    override method image() = "esquina_3.png"
}

class Esquina4 inherits Calle (){

    override method image() = "esquina_4.png"
}

class CalleHorizontal inherits Calle (){

    override method image() = "calleHorizontal.png"
}

class CalleVertical inherits Calle (){

    override method image() = "calleVertical.png"
}

class Vereda {
    const property position 

    method solida() {
		return true
	}

    method image()

    method esAgarrable(){
        return false
    }
}

class VIzqArriba inherits Vereda (){

    override method image() = "vIzqArriba.png"
}

class VHorArriba inherits Vereda (){

    override method image() = "vHorArriba.png"
}

class VDerArriba inherits Vereda (){

    override method image() = "vDerArriba.png"
}

class VVertDer inherits Vereda (){

    override method image() = "vVertDer.png"
}

class VDerAbajo inherits Vereda (){

    override method image() = "vDerAbajo.png"
}

class VHorAbajo inherits Vereda (){

    override method image() = "vHorAbajo.png"
}

class VIzqAbajo inherits Vereda (){

    override method image() = "vIzqAbajo.png"
}

class VVertIzq inherits Vereda (){

    override method image() = "vVerticalIzq.png"
}

class VEsqInfDer inherits Vereda (){

    override method image() = "vEsqInfDer.png"
}
// class VEsqInfIzq inherits Vereda (){

//     override method image() = "vEsqInfIzq.png"
// }
// class VEsqSupDer inherits Vereda (){

//     override method image() = "vEsqSupDer.png"
// }
// class VEsqSupIzq inherits Vereda (){

//     override method image() = "vEsqSupIzq.png"
// }
