import personaje.*
import interfaz.*
import juego.*
import cartas.*
class Nivel {
    const jugador = poro
    const property enemigo
    const property numeroDeNivel 
    const property cantidadDeMazo    
    method iniciar() {
        game.clear()
        jugador.desasignarCartas()
        jugador.limpiarMazo()
        jugador.reiniciarCooldowns()
        jugador.maximaVida()
        enemigo.maximaVida()
        jugador.llenarMazo(cantidadDeMazo)
        poro.enemigoNuevo(enemigo)
        interfaz.mostrarNivel(enemigo)
    }
}

object nivelUno inherits Nivel(numeroDeNivel = 1, enemigo = vacuolarva, cantidadDeMazo = 3) {
    method siguiente() = nivelDos
}

object nivelDos inherits Nivel(numeroDeNivel = 2, enemigo = heraldo, cantidadDeMazo = 4){
    method siguiente() = nivelUno
}

