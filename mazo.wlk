import nivel.*
import cartas.*
import personaje.*
import interfaz.*
import juego.*

class Mazo {
    var duenio
    var coleccion = duenio.coleccion()
    var nivelActual = juego.nivel()
    const property cartas = []
    const cantidadDeCartas = nivelActual.cantidadDeMazo()

    method agregarCartasDeColeccion() { coleccion.forEach{c=>self.agregarCarta(c)} }

    method asignarSusPosiciones() { cartas.forEach{ c=>c.asignarPosicion() } }

    method agregarCarta(carta) { cartas.add(carta) }

    method borrarCartas() { cartas.clear() }

    method actualizarNivel(unNivel) { nivelActual = unNivel }

}

