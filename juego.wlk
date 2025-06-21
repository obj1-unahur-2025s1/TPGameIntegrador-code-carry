import personaje.*
import interfaz.*
import nivel.*
import cartas.*
object juego {
    var nivel = nivelUno
    var enemigo = nivel.enemigo()
    method nivel() = nivel
    const musicaFondo= new Sound(file = "Worlds-London-MusicaFondo.mp3")
    const aparicionHeraldo= new Sound(file="AudioHeraldo.mp3")
    const aparicionBaron= new Sound(file="AlertaBaron.mp3")


    method iniciar() {
        self.campeonesInicales()
        nivel.iniciar()
        if(nivel == nivelDos) self.aparicionEnemigo(aparicionHeraldo) 
        self.iniciarMusicaFondo()
        self.teclasDeCombate()
        
        
    }

    method iniciarMusicaFondo(){
        musicaFondo.shouldLoop(true)
        musicaFondo.volume(0.1)
        musicaFondo.play()
    }

    method aparicionEnemigo(unaAparicion){
        unaAparicion.volume(1)
        unaAparicion.play()
    }

    method reiniciarPartida() {
        nivel = nivelUno
        self.iniciar()
    }

    method subirDeNivel() {
        nivel = nivel.siguiente()
        self.iniciar()
    }

    method campeonesInicales() {
        poro.agregarALaColeccion(garen)
        poro.agregarALaColeccion(soraka)
        poro.agregarALaColeccion(draven)
        poro.agregarALaColeccion(ahri)
        poro.agregarALaColeccion(aatrox)
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
}