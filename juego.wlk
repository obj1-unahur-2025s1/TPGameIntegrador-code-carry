import personaje.*
import interfaz.*
import nivel.*
import cartas.*
import sonido.*
import menu.*
import modelos.*
object juego {
    var nivel = nivelUno // Reconoce el nivel actual
    var enemigo = nivel.enemigo() // Seteamos el enemigo que lo reconoce desde el nivel
    method nivel() = nivel // musica de la batalla
    const property todasLasCartas = [aatrox,ahri,alistar,amumu,ashe,aurelion,blitz,brand,camille,draven,fiora,jhin,garen,pyke,nasus,morgana,soraka,karma]
    method iniciar() {
        nivel.iniciar() // inicia el nivel
        enemigo.sonidoAparicion().iniciar()
        sonidoDeFondo.iniciar() // inicia la musica de batalla
        self.teclasDeCombate() // setea las teclas para atacar
    }

    method reiniciarPartida() {
        nivel = nivelUno
        self.iniciar()
    }

    method iniciarDe0(){
        nivel = nivelUno
        enemigo = nivel.enemigo()
        self.iniciar()
    }

    method subirDeNivel() {
        nivel = nivel.siguiente()
        if(nivel == menu) {
            menu.iniciar()
        }
        else {
            enemigo = nivel.enemigo()
            self.iniciar()
        }
    }

    method teclasDeCombate() {
        keyboard.z().onPressDo{poro.atacar()}
        keyboard.c().onPressDo{poro.curarse()}   
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
    }
}