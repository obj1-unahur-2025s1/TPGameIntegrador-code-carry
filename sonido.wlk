object sonidoDeFondo {
    const sonido = new Sound(file = "Worlds-London-MusicaFondo.mp3")

    method iniciar(){
        sonido.shouldLoop(true)
        sonido.volume(0.05)
        sonido.play()
    }

    method parar() { sonido.stop() }
}

object sonidoDeMenu{
   

    method iniciarSonidoMenu() {
        const sonidoMenu = new Sound(file="Menu-Seleccion.mp3")
        sonidoMenu.volume(1)
        sonidoMenu.play()
    }
  
}

object sonidoDeHeal {
    method iniciar() {
        const sonidoHeal = new Sound(file = "HaelSound.mp3")
        sonidoHeal.play()
    }
}