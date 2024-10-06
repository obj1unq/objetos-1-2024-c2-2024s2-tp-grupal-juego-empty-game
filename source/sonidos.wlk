import wollok.game.*

object sape {

    method play(){
        game.sound("sape-sape.mp3").play()
    }
}

object sonidoFondo{

    method play(){
        game.sound("echo-in-the-night.mp3").play()
    }

    //method volume(valor){
    //    game.sound("echo-in-the-night.mp3").volume(valor)
    //}
}