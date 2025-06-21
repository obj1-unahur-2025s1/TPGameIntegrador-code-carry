import nivel.*
import personaje.*
import juego.*

object interfaz {
    method mostrarNivel(enemigo) {
        game.boardGround("fondoBatalla.jpg")
        game.addVisual(nivelInterfaz)
        game.addVisual(poro)
        game.addVisual(barraDePoro)
        game.say(poro, "Presiona Q/W/E/R/T para usar cartas")
        barraDeEnemigo.cambiar(enemigo)
        game.addVisual(enemigo)
        game.addVisual(barraDeEnemigo)
        turnoDe.enemigoActual(enemigo)
        game.addVisual(turnoDe)
        game.addVisual(boolPrueba)

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
    method text() = "TOQUE ENTER PARA COMENZAR 

    C PARA VER COLECCIONES 

    I PARA VER INSTRUCCIONES."
    method textColor() = paleta.blanco()
    method position() = game.center()
}

object menuInstrucciones {
    method text() = "INSTRUCCIONES
        - ¡Recupera tus Porogalletas!
        - El juego es por turnos y se juega con cartas (Q/W/E/R/T)
        - Cada carta tiene un cooldown y efecto especial.
        - Peleas en 3 niveles contra: 
        1. Larva del Vacio 
        2. Heraldo de la Grieta 
        3. Baron Nashor.
        - Si ganas los 3 niveles, recuperas tus Porogalletas.
        - Si pierdes, podes reintentar una vez mas el nivel.
        - Si pierdes tus intentos, vuelves al inicio.

        ENTER para vovler al menu"
    method textColor() = paleta.blanco()
    method position() = game.center()
}

//object menuColecciones {
  //  method text() = "COLECCION DE CARTAS DISPONIBLES: " +  nombre de cartas + ":" + descripcion de las cartas + 
    //"ENTER para vovler al menu"
   // method textColor() = paleta.blanco()
    //method position() = game.center()
//}



object turnoDe {
    var enemigo = null
    method enemigoActual(nuevo) { enemigo = nuevo }
    method text() = if (poro.esSuTurno()) "Es tu turno" else "Es el turno de " + enemigo.nombre()
    method position() = game.at(12,11)
    method textColor() = if (poro.esSuTurno()) paleta.verde() else paleta.rojo()
}

object enemigoMuerto {
    method text() = "¡El enemigo " + juego.nivel().enemigo().nombre() + " a sido derrotado!" 
    method textColor() = paleta.amarillo()
    method position() = game.at(12,14)
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
        personaje.mazo().forEach{ c=>
            game.addVisual(c)
            game.addVisual(new CooldownInterfaz(carta = c, posicion = c.posicionDelCooldown()))
            game.addVisual(new Tecla(carta = c))
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