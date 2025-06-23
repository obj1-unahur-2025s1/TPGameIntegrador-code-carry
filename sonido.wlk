object sonidoDeFondo {
    const sonido = new Sound(file = "Worlds-London-MusicaFondo.mp3")

    method iniciar(){
        sonido.shouldLoop(true)
        sonido.volume(0.05)
        sonido.play()
    }

    method parar() { sonido.stop() }
}