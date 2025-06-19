import wollok.game.*
import personajes.*
import estadoMenu.*
import estadoCombate.*
import nivel.*
import cartas.*

object juego {
    var property estado = estadoCombate
    var property jugador = poro
    var property enemigo = enemigoNivel1
    var property nivelActual = 1 
    var property intentosFallidos = 0

    method elegirPoro() {jugador = poro}

    method inicio(){
        nivelActual = 1
        estado = estadoCombate
        self.teclasDelCombate()
        nivelActual.iniciar(nivelActual)
    } 

    method teclasDelMenu(){
        keyboard.enter().onPressDo{estado.continuar()}
    }

    method teclasDelCombate(){
        keyboard.q().onPressDo({estado.usarCartaEnTurno(0)})
        keyboard.w().onPressDo({estado.usarCartaEnTurno(1)})
        keyboard.e().onPressDo({estado.usarCartaEnTurno(2)})
        keyboard.r().onPressDo({estado.usarCartaEnTurno(3)})
        keyboard.t().onPressDo({estado.usarCartaEnTurno(4)})
    }
    
}
