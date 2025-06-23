import personaje.*
import interfaz.*
import nivel.*
import cartas.*
import sonido.*
object juego {
    var nivel = nivelUno // Reconoce el nivel actual
    var enemigo = nivel.enemigo() // Seteamos el enemigo que lo reconoce desde el nivel
    method nivel() = nivel // musica de la batalla
    //const aparicionBaron= new Sound(file="AlertaBaron.mp3") // musica al aparecer el baron
    method iniciar() {
        nivel.iniciar() // inicia el nivel
        enemigo.sonidoAparicion().play()
        sonidoDeFondo.iniciar() // inicia la musica de batalla
        self.teclasDeCombate() // setea las teclas para atacar
    }

    method reiniciarPartida() {
        sonidoDeFondo.parar()
        nivel = nivelUno
        self.iniciar()
    }

    method subirDeNivel() {
        sonidoDeFondo.parar()
        nivel = nivel.siguiente()
        enemigo = nivel.enemigo()
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
        poro.agregarALaColeccion(aatrox)
        poro.agregarALaColeccion(ahri)
        poro.agregarALaColeccion(alistar)
        poro.agregarALaColeccion(amumu)
        poro.agregarALaColeccion(ashe)
        poro.agregarALaColeccion(aurelion)
        poro.agregarALaColeccion(blitz)
        poro.agregarALaColeccion(brand)
        poro.agregarALaColeccion(camille)
        poro.agregarALaColeccion(draven)
        poro.agregarALaColeccion(fiora)
        poro.agregarALaColeccion(garen)
        poro.agregarALaColeccion(jhin)
        poro.agregarALaColeccion(karma)
        poro.agregarALaColeccion(morgana)
        poro.agregarALaColeccion(nasus)
        poro.agregarALaColeccion(pyke)
        poro.agregarALaColeccion(soraka)
    }
}