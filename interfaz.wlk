import nivel.*
import personaje.*
import juego.*

object interfaz {
    method mostrarNivel(enemigo) {
        game.boardGround("fondoJuego.jpg")
        game.addVisual(nivelInterfaz)
        game.addVisual(poro)
        game.addVisual(barraDePoro)
        game.say(poro, "Presiona Q/W/E/R/T para usar cartas")
        barraDeEnemigo.cambiar(enemigo)
        game.addVisual(enemigo)
        game.addVisual(barraDeEnemigo)
        turnoDe.enemigoActual(enemigo)
        game.addVisual(turnoDe)
        //game.addVisual(boolPrueba)

        cartasInterfaz.mostrarCartas(poro)
    }
}


class BarraDeVida {
    var personaje
    const posicion
    method text() = "VIDA:" + personaje.vida().toString()
    method textColor() = if (personaje.vida() == 0) paleta.rojo() else paleta.blanco()
    method position() = posicion

    method cambiar(nuevo) { personaje = nuevo }
}

object nivelInterfaz {
    method text() = "NIVEL " + juego.nivel().numeroDeNivel().toString() + " : " + juego.nivel().enemigo().nombre()
    method textColor() = paleta.blanco()
    method position() = game.at(12,16)
}

object paleta {
    const property blanco = "FFFFFF"
    const property rojo = "FF0000"
    const property verde = "00FF00"
    const property amarillo = "FFFF00"
    const property azul = "0000FF"
}

object barraDePoro inherits BarraDeVida(personaje = poro, posicion = game.at(7,1)) {}


object barraDeEnemigo inherits BarraDeVida(personaje = juego.nivel().enemigo(), posicion = game.at(17,1)) {
}

object menuCartel {
    method text() = "TOQUE ENTER PARA COMENZAR"
    method textColor() = paleta.blanco()
    method position() = game.center()
}





object turnoDe {
    var enemigo = null
    method enemigoActual(nuevo) { enemigo = nuevo }
    method text() = if (poro.esSuTurno()) "Es tu turno" else "Es el turno de " + enemigo.nombre()
    method position() = game.at(12,11)
    method textColor() = if (poro.esSuTurno()) paleta.verde() else paleta.rojo()
}

object enemigoMuerto {
    method text() = "ENEMIGO DERROTADO"
    method textColor() = paleta.amarillo()
    method position() = game.at(10,14)
}

object boolPrueba {
    method text() = poro.esSuTurno().toString() + " " + juego.nivel().enemigo().esSuTurno().toString()
    method position() = game.center()
}

object nivelCompletado {
    method text() = "TOQUE ENTER PARA PASAR AL SIGUIENTE NIVEL"
    method position() = game.center()
    method textColor() = paleta.blanco()
}

object danioInflijido {
    var danioInflijido = null
    var posicion = null
    var especie = null
    method tipo(nuevo) { especie = nuevo }
    method posicionEnemigo(nueva) { posicion = nueva }
    method corroborarDanio(danio) { danioInflijido = danio }
    method text() = "-" + danioInflijido.toString()
    method textColor() { 
        var color = paleta.rojo()
        if (!especie.esAD()) {

            color = paleta.azul()
        }
        return color
        }
     
    method position() = game.at(posicion.x()+3, posicion.y() +3)
}

object curacionTotal {
    var curacionRecibida = null
    var posicion = null
    method posicionMia(nueva) { posicion = nueva }
    method corroborarCuracion(curazao) { curacionRecibida = curazao }
    method text() = "+"+ curacionRecibida.toString()
    method textColor() = paleta.verde()
    method position() = game.at(posicion.x()+3, posicion.y() +3)
}
class CooldownInterfaz {
    var carta
    var posicion
    method text() = if (carta.cooldown() != 0 ) carta.cooldown().toString() else ""
    method textColor() = paleta.blanco()
    method position() = game.at(carta.position().x()+1, carta.position().y() + 1)
}

class Tecla {
    var carta
    method text() = carta.tecla()
    method position() = game.at(carta.position().x()+2, carta.position().y()+2)
    method textColor() = paleta.blanco()
}

object cartasInterfaz { 
    method mostrarCartas(personaje) { 
        personaje.coleccion().forEach{ c=>
            game.addVisualCharacter(c)
            game.addVisual(new CooldownInterfaz(carta = c, posicion = c.posicionDelCooldown()))
            game.addVisual(new Tecla(carta = c))
            game.showAttributes(c)
        }
    }
}

object posicionUno {
    method posicionCarta() = game.at(1,13)
    method posicionCooldown() = self.posicionCarta()
}

object posicionDos {
    method posicionCarta() = game.at(1,10)
    method posicionCooldown() = self.posicionCarta()
}

object posicionTres {
    method posicionCarta() = game.at(1,7)
    method posicionCooldown() = self.posicionCarta()
}

object posicionCuatro {
    method posicionCarta() = game.at(1,4)
    method posicionCooldown() = self.posicionCarta()
}

object posicionCinco {
    method posicionCarta() = game.at(1,1)
    method posicionCooldown() = self.posicionCarta()
}