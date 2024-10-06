import wollok.game.*

object arriba {

    method siguiente(position) {
        return position.up(1)
    }
    method imagen(){
        return "autoHaciaArriba.png"
    }
}

object abajo {
    method siguiente(position) {
        return position.down(1)
    }
    method imagen(){
        return "autoHaciaAbajo.png"
    }
}

object izquierda {
    method siguiente(position) {
        return position.left(1)
    }
    method imagen(){
        return "autoHaciaIzquierda.png"
    }
}

object derecha {
    method siguiente(position) {
        return position.right(1)
    }
    method imagen(){
        return "autoHaciaDerecha.png"
    }
}