import personaBase.*
import chefs.*
import clientes.*

//PONER UN LIMITE AL EJE X PORQUE EL EJE Y ES BLOQUEADO POR MUEBLES

class Direccion{

	method imageOrientacion(name)

	method dondeMoverse(positionPersona)

	//method dondeMoverse(positionPersona, distancia)

	method moverse(persona){
		self.newImagen(persona)
		self.validarMoverse(persona)
		self.mover(persona)
	}

	//method moverse(persona, distancia){
	//	self.newImagen(persona)
	//	self.validarMoverse(persona, distancia)
	//	self.mover(persona, distancia)
	//}

	method validarMoverse(persona){
		if(persona.ubicacion().hayMuebleAqui(self.dondeMoverse(persona.position()))){
			self.error("no se puede mover ahí")	
		}
	}

	//method validarMoverse(persona, distancia){
	//	if(persona.ubicacion().hayMuebleAqui(self.dondeMoverse(persona.position(), distancia))){
	//		self.error("no se puede mover ahí")	
	//	}
	//}

	method mover(persona){
		persona.position(self.dondeMoverse(persona.position()))
	}

	//method mover(persona, distancia){
	//	persona.position(self.dondeMoverse(persona.position(), distancia))
	//}

	method newImagen(persona){
		persona.image(self.imageOrientacion(persona.name()))
	}

}

object arriba inherits Direccion {

	override method imageOrientacion(name){
		return "" + name + "_up.png" 
	}

	override method dondeMoverse(positionPersona){
		return positionPersona.up(1)
	}

	//override method dondeMoverse(positionPersona, distancia){
	//	return positionPersona.up(distancia)
	//}
  
}


object abajo inherits Direccion {

	override method imageOrientacion(name) {
		return "" + name + "_down.png" 
	}

	override method dondeMoverse(positionPersona) {
	  return positionPersona.down(1)
	}
	
	//override method dondeMoverse(positionPersona, distancia) {
	//  return positionPersona.down(distancia)
	//}
}

object izquierda inherits Direccion {

	override method imageOrientacion(name) {
		return "" + name + "_left.png" 
	}

	override method dondeMoverse(positionPersona) {
	  return positionPersona.left(1)
	}

	//override method dondeMoverse(positionPersona, distancia) {
	//  return positionPersona.left(distancia)
	//}
}

object derecha inherits Direccion {

	override method imageOrientacion(name) {
		return "" + name + "_right.png"
	}

	override method dondeMoverse(positionPersona) {
	  return positionPersona.right(1)
	}

	//override method dondeMoverse(positionPersona, distancia) {
	 // return positionPersona.right(distancia)
	//}
}
