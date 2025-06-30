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

// Sonidos de cartas
const sonidoCartaCuracion = new Sound(file = "Sonido-Carta-Supp3.mp3")

const sonidoCartaDanio = new Sound(file = "Sonido-Carta-AD.mp3")

const sonidoCartaMagia = new Sound(file = "Sonido-Carta-AP.mp3")

// Sonidos de personajes

const sonidoAtaquePoro = new Sound(file="BolaDeNieve.mp3") // Poro

const sonidoAtaqueLarva = new Sound(file="AtaqueLarva.mp3") // Larva

const sonidoAparicionLarva = new Sound(file="AparicionLarva.mp3") // Larva

const sonidoAparicionHeraldo = new Sound(file="AparicionHeraldo.mp3") // Heraldo

const sonidoAparicionBaron = new Sound(file = "AlertaBaron.mp3") // Baron