import wollok.game.*

object musicaDeFondo{

    var property volumen = 0.5 
    
    method tema(){
        return game.sound("echo-in-the-night.mp3")
    }

    method volumeUp(num){
        volumen += num
    }

    method volumeDown(num){
        volumen += num 
    }
}