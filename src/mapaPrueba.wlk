import wollok.game.*
import auto.*
import cosas.*
import reloj.*
import barraSuperior.*
import caminos.*

object mapa {
  const tablero = [
    [__, __, __, __, __, __, __, __, __, __],     //reloj + frame
    [__, __, v5, c6, v3, __, __, __, __, __],
    [__, __, v5, c6, v3, __, __, __, __, __],
    [__, __, v5, c6, v3, __, __, __, __, __],
    [__, __, v5, c6, v3, __, __, __, __, __],
    [__, __, v5, c6, v3, __, __, __, __, __],
    [__, __, v5, c6, v3, __, __, __, __, __],
    [v7, v7, v7, c6, v3, __, __, __, __, __],
    [c1, c5, c5, c3, v3, __, __, __, __, __],
    [c6, v2, v2, v2, v9, __, __, __, __, __]
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
    game.addVisual(new VIzqArriba(position = position))
  }
}

object v2 {
  method dibujarEn(position) {
    game.addVisual(new VHorArriba(position = position))
  }
}

object v3 {
  method dibujarEn(position) {
    game.addVisual(new VVertIzq(position = position))
  }
}

object v4 {
  method dibujarEn(position) {
    game.addVisual(new VDerArriba(position = position))
  }
}

object v5 {
  method dibujarEn(position) {
    game.addVisual(new VVertDer(position = position))
  }
}

object v6 {
  method dibujarEn(position) {
    game.addVisual(new VDerAbajo(position = position))
  }
}

object v7 {
  method dibujarEn(position) {
    game.addVisual(new VHorAbajo(position = position))
  }
}

object v8 {
  method dibujarEn(position) {
    game.addVisual(new VIzqAbajo(position = position))
  }
}

object v9 {
  method dibujarEn(position) {
    game.addVisual(new VEsqInfDer(position = position))
  }
}

//A CHEQUEAR LAS ESQUINAS, LA CANTIDAD Y LOS DIBUJITOS
// object v10 {
//   method dibujarEn(position) {
//     game.addVisual(new VEsqInfIzq(position = position))
//   }
// }
// object v11 {
//   method dibujarEn(position) {
//     game.addVisual(new VEsqSupDer(position = position))
//   }
// }
// object v12 {
//   method dibujarEn(position) {
//     game.addVisual(new VEsqSupIzq(position = position))
//   }
// }
