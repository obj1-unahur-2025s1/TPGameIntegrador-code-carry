import personaje.*
import interfaz.*
import nivel.*
import cartas.*
object juego {
    var nivel = nivelUno // Reconoce el nivel actual
    var enemigo = nivel.enemigo() // Seteamos el enemigo que lo reconoce desde el nivel
    method nivel() = nivel
    const musicaFondo= new Sound(file = "Worlds-London-MusicaFondo.mp3") // musica de la batalla
    //const aparicionBaron= new Sound(file="AlertaBaron.mp3") // musica al aparecer el baron
    method iniciar() {
        nivel.iniciar() // inicia el nivel
        enemigo.sonidoAparicion().play()
        self.iniciarMusicaFondo() // inicia la musica de batalla
        self.teclasDeCombate() // setea las teclas para atacar
    }

    method iniciarMusicaFondo(){
        musicaFondo.shouldLoop(true)
        musicaFondo.volume(0.05)
        musicaFondo.play()
    }

    method reiniciarPartida() {
        nivel = nivelUno
        self.iniciar()
    }

    method subirDeNivel() {
        musicaFondo.stop()
        nivel = nivel.siguiente()
        self.iniciar()
    }

    method teclasDeCombate() {
        //TEST
        keyboard.z().onPressDo{poro.atacar()}
        keyboard.x().onPressDo{enemigo.atacar()}
        keyboard.c().onPressDo{poro.curarse()}
        keyboard.v().onPressDo{enemigo.curarse()}

        //CARTAS
        keyboard.q().onPressDo{poro.usarLaCarta(1)}
        keyboard.w().onPressDo{poro.usarLaCarta(2)}
        keyboard.e().onPressDo{poro.usarLaCarta(3)}
        keyboard.r().onPressDo{poro.usarLaCarta(4)}
        keyboard.t().onPressDo{poro.usarLaCarta(5)}
    }

    method campeonesInicales() {
        poro.agregarALaColeccion(garen)
        poro.agregarALaColeccion(soraka)
        poro.agregarALaColeccion(draven)
        poro.agregarALaColeccion(ahri)
        poro.agregarALaColeccion(aatrox)
    }
}