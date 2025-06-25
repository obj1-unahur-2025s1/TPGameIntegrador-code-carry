import menu.*
import personaje.*
import interfaz.*
import juego.*
import cartas.*

class Nivel {
    const jugador = poro // Poro
    const property enemigo // Enemigo del nivel
    const property numeroDeNivel // Numero del nivel
    const property cantidadDeMazo   // Cantidad maxima del mazo que permite el nivel
    method iniciar() {
        game.clear() // Limpia el tablero
        game.addVisual(fondoBatalla) // Agrega el fondo de batalla
        self.campeonesInicialesEnemigo()
        jugador.desasignarCartas() // Desasigna las ubicaciones cartas 
        jugador.limpiarMazo() // Limpia el mazo
        jugador.reiniciarCooldowns() // Reinicia el cooldowns de las cartas
        enemigo.reiniciarCooldowns()
        jugador.maximaVida() // Maxima vida al poro
        enemigo.maximaVida() // Maxima vida al enemigo
        jugador.llenarMazo(cantidadDeMazo) // Llena el mazo segun la cantidad que permita el nivel
        enemigo.llenarMazo(cantidadDeMazo)
        poro.enemigoNuevo(enemigo) // El poro eligue como target al nuevo enemigo
        self.iniciarJugador() // Hace que el jugador inicie los turnos
        interfaz.mostrarNivel(enemigo) // Añade al enemigo en pantalla
    }

    method iniciarJugador() {
        if (enemigo.esSuTurno()){
            enemigo.cambiarTurno()
        }
        if (!jugador.esSuTurno()){
            jugador.cambiarTurno()
        }
    }

    method campeonesInicialesEnemigo() {
        enemigo.agregarALaColeccion(draven)
        enemigo.agregarALaColeccion(fiora)
        enemigo.agregarALaColeccion(garen)
        enemigo.agregarALaColeccion(jhin)
        enemigo.agregarALaColeccion(karma)
        enemigo.agregarALaColeccion(morgana)
        enemigo.agregarALaColeccion(nasus)
        enemigo.agregarALaColeccion(pyke)
        enemigo.agregarALaColeccion(soraka)
    }
}

object nivelUno inherits Nivel(numeroDeNivel = 1, enemigo = vacuolarva, cantidadDeMazo = 3) {
    method siguiente() = nivelDos
}

object nivelDos inherits Nivel(numeroDeNivel = 2, enemigo = heraldo, cantidadDeMazo = 4){
    method siguiente() = nivelTres
}

object nivelTres inherits Nivel(numeroDeNivel = 3, enemigo = baron, cantidadDeMazo = 5){
    method siguiente() = menu
}