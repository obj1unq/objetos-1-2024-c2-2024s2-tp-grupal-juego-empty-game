import wollok.game.*

object inicio {
  var property estado = intro0
  
  method position() = game.at(0, 0)
  
  method image() = estado.image()
  
  method cambiar() {
    estado = estado.siguiente()
    if(not estado.seguirMostrando()){
        game.removeVisual(self)
    }
    
    }
}


object intro0 {
    const property image = "intro-0.png"
    method siguiente() = intro1
    method seguirMostrando() = true

}


object intro1 {
    const property image = "intro_1.png"
    method siguiente() = intro2
    method seguirMostrando() = true

  
}
object intro2 {
    const property image = "intro_2.png"
    method siguiente() = intro3
    method seguirMostrando() = true

  
}

object intro3 {
    const property image = "intro_3.png"
    method siguiente() = intro4
    method seguirMostrando() = true

  
}

object intro4 {
    const property image = "intro_4.png"
    method siguiente() = intro5
    method seguirMostrando() = true

  
}

object intro5 { //en realidad no existe, pero es para poder 
    const property image = "intro5.png"
    method siguiente() = self

    method seguirMostrando() = false
  
}