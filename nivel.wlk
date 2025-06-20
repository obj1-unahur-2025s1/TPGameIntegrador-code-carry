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
        poro.reiniciarCooldowns()
        poro.maximaVida()
        enemigo.maximaVida()
        jugador.agregarALaColeccion(ahri)
        jugador.agregarALaColeccion(garen)
        jugador.agregarALaColeccion(soraka)
        jugador.agregarALaColeccion(draven)
        jugador.agregarALaColeccion(aatrox)
        poro.enemigoNuevo(enemigo)
        interfaz.mostrarNivel(enemigo)
    }
}

object nivelUno inherits Nivel(numeroDeNivel = 1, enemigo = vacuolarva, cantidadDeMazo = 2) {
    method siguiente() = nivelDos
}

object nivelDos inherits Nivel(numeroDeNivel = 2, enemigo = enemigo2, cantidadDeMazo = 5){
    method siguiente() = nivelUno
}

