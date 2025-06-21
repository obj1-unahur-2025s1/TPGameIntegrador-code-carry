import personaje.*
import interfaz.*
import nivel.*
import cartas.*
object juego {
    var nivel = nivelUno
    var enemigo = nivel.enemigo()
    method nivel() = nivel

    method iniciar() {
        self.campeonesInicales()
        nivel.iniciar()
        self.teclasDeCombate()
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