import wollok.game.*
import auto.*
import cosas.*
import reloj.*
import barraSuperior.*
import caminos.*

object mapa {
  const tablero = [
    [__, __, __, __, __, __, __, __, __, __],     //reloj + frame
    [__, __, v1, c6, v1, __, __, __, __, __],
    [h1, __, v1, c6, v1, __, h1, __, __, __],
    [__, __, v1, c6, v1, __, __, __, h2, __],
    [h1, __, v1, c6, v1, __, __, __, __, __],
    [__, __, v1, c6, v1, __, __, h3, __, __],
    [h1, __, v1, c6, v1, __, __, __, h3, __],
    [v1, v1, v1, c6, v1, h1, __, __, __, __],
    [c2, c5, c5, c3, v1, __, __, __, __, __],
    [c6, v1, v1, v1, v1, __, __, __, __, __]
  ].reverse()
  
  method dibujar() {
    game.height(tablero.size())
    game.width(tablero.get(0).size())
    (0 .. (game.width() - 1)).forEach(
      { x => (0 .. (game.height() - 1)).forEach(
          { y => tablero.get(y).get(x).dibujarEn(game.at(x, y)) }
        ) }
    )

    game.addVisual(auto) 
    game.addVisual(new Mate(position = game.at(3,1)))

  }
} 

object __ {
  method dibujarEn(position) {
    
  }
}

object a {
  method dibujarEn(position) {
    auto.position(position)
  }
}

object c1 {
  method dibujarEn(position) {
    game.addVisual(new Esquina1(position = position))
  }
}

object c2 {
  method dibujarEn(position) {
    game.addVisual(new Esquina2(position = position))
  }
}

object c3 {
  method dibujarEn(position) {
    game.addVisual(new Esquina3(position = position))
  }
}

object c4 {
  method dibujarEn(position) {
    game.addVisual(new Esquina4(position = position))
  }
}

object c5 {
  method dibujarEn(position) {
    game.addVisual(new CalleHorizontal(position = position))
  }
}

object c6 {
  method dibujarEn(position) {
    game.addVisual(new CalleVertical(position = position))
  }
}

object v1 {
  method dibujarEn(position) {
    game.addVisual(new Vereda(position = position))
  }
}

object h1 {
    method dibujarEn(position) {
    game.addVisual(new Casa1(position = position))
  }
}

object h2 {
    method dibujarEn(position) {
    game.addVisual(new Casa2(position = position))
  }
}

object h3 {
    method dibujarEn(position) {
    game.addVisual(new Casa3(position = position))
  }
}
