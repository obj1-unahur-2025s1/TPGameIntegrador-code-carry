
class Sonido{
    const archivo
    const volume
    const loop 

    method iniciar(){
        const sonido= new Sound(file = archivo)
        sonido.shouldLoop(loop)
        sonido.volume(volume)
        sonido.play()
    }
}

// Sonido de fondo
const sonidoDeFondo = new Sonido(archivo = "Worlds-London-MusicaFondo.mp3",volume= 0.03,loop= true)
// Sonido de menu
const sonidoDeMenu = new Sonido(archivo = "Menu-Seleccion.mp3",volume= 1,loop= false)

// Sonido de curacion
const sonidoDeHeal = new Sonido(archivo = "HaelSound.mp3",volume= 1,loop= false)

// Sonidos de cartas
const sonidoCartaCuracion = new Sonido(archivo = "Sonido-Carta-Supp3.mp3",volume= 1,loop= false)

const sonidoCartaDanio = new Sonido(archivo = "Sonido-Carta-AD.mp3",volume= 1,loop= false)

const sonidoCartaMagia = new Sonido(archivo = "Sonido-Carta-AP.mp3",volume= 1,loop= false)

// Sonidos de personajes

const sonidoAtaquePoro = new Sonido(archivo="BolaDeNieve.mp3",volume= 1,loop= false) // Poro

const sonidoAtaqueLarva = new Sonido(archivo="AtaqueLarva.mp3",volume= 1,loop= false) // Larva

const sonidoAparicionLarva = new Sonido(archivo="AparicionLarva.mp3",volume= 1,loop= false) // Larva

const sonidoAparicionHeraldo = new Sonido(archivo="AparicionHeraldo.mp3",volume= 1,loop= false) // Heraldo

const sonidoAparicionBaron = new Sonido(archivo = "AlertaBaron.mp3",volume= 1,loop= false) // Baron