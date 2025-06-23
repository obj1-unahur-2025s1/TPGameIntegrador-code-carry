import nivel.*
import personaje.*
import juego.*
import menu.*

object interfaz {
    method mostrarNivel(enemigo) {
        //game.boardGround("fondoBatalla.jpg")    
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
        cartasMazoInGame.mostrar()
    }
}

// ----------PALETA DE COLORES----------

object paleta {
    const property blanco = "FFFFFF"
    const property rojo = "FF0000"
    const property verde = "00FF00"
    const property amarillo = "FFFF00"
    const property azul = "0000FF"
    const property violeta = "6100FF"
}

// ----------MENU----------

class Opciones {
    var estaSeleccionado
    method text()
    method position()
    method textColor() = if (self.estaSeleccionado()) paleta.verde() else paleta.blanco() 
    method estaSeleccionado() = estaSeleccionado
    method cambiarSeleccion() { if (estaSeleccionado) estaSeleccionado = false else estaSeleccionado = true }
    method entrar() {}
}

object iniciarJuego inherits Opciones(estaSeleccionado = true){
    override method text() = "NUEVA PARTIDA"
    override method position() = game.at(12,10)
    override method entrar() { juego.iniciar() }
}

object irAlInventario inherits Opciones(estaSeleccionado = false) {
    override method text() = "COLECCION"
    override method position() = game.at(12,9)
    override method entrar() { inventarioPrueba.mostrarCartas() } // ESTOY TESTEANDO LA COLECCION
} 

object irAInstrucciones inherits Opciones(estaSeleccionado = false) {
    override method text() = "INSTRUCCIONES" 
    override method position() = game.at(12,8)
    override method entrar() { instrucciones.mostrar() }
}

object salir inherits Opciones(estaSeleccionado = false){
    override method text() = "SALIR"
    override method position() = game.at(12,7)
    override method entrar() { game.stop() }
}

object instrucciones {
    method mostrar() {
        game.clear()
        game.addVisual(fondoInstrucciones)
        game.addVisual(menuInstrucciones)
        game.addVisual(mensajeVolverAlMenu)
        keyboard.enter().onPressDo{menu.mostrarMenu()}
    }
}

object mensajeVolverAlMenu inherits Opciones(estaSeleccionado = false) {
    override method position() = game.at(12,1)
    override method text() = "Presione ENTER para volver al menu"
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

        "
    method textColor() = paleta.blanco()
    method position() = game.center()
}

// ----------TESTING----------

object boolPrueba {
    method text() = poro.esSuTurno().toString() + " " + juego.nivel().enemigo().esSuTurno().toString()
    method position() = game.center()
}

// ----------INTERFACES IN GAME----------

class BarraDeVida {
    var personaje
    const posicion
    method text() = "VIDA:" + personaje.vida().toString()
    method textColor() = if (personaje.vida() == 0) paleta.rojo() else paleta.blanco()
    method position() = posicion

    method cambiar(nuevo) { personaje = nuevo }
}

object barraDePoro inherits BarraDeVida(personaje = poro, posicion = game.at(7,1)) {}

object barraDeEnemigo inherits BarraDeVida(personaje = juego.nivel().enemigo(), posicion = game.at(17,1)) {
    override method textColor() = if (personaje.vida() == 0) paleta.rojo() else paleta.violeta()
}

object nivelInterfaz {
    method text() = "NIVEL " + juego.nivel().numeroDeNivel().toString() + " : " + juego.nivel().enemigo().nombre()
    method textColor() = paleta.blanco()
    method position() = game.at(12,16)
}

object turnoDe {
    var enemigo = null
    method enemigoActual(nuevo) { enemigo = nuevo }
    method text() = if (poro.esSuTurno()) "Es tu turno" else "Es el turno de " + enemigo.nombre()
    method position() = game.at(12,11)
    method textColor() = if (poro.esSuTurno()) paleta.verde() else paleta.rojo()
}

object nivelCompletado {
    method text() = "TOQUE ENTER PARA PASAR AL SIGUIENTE NIVEL"
    method position() = game.center()
    method textColor() = paleta.blanco()
}

object enemigoMuerto {
    method text() = "¡El enemigo " + juego.nivel().enemigo().nombre() + " a sido derrotado!" 
    method textColor() = paleta.amarillo()
    method position() = game.at(12,14)
}

// ----------MOSTRAR DAMAGE O HEALTH----------

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

// ----------POSICION DE LAS CARTAS IN GAME----------

object cartasInterfaz { 
    method mostrarCartas(personaje) { 
        personaje.mazo().forEach{ c=>
            game.addVisual(c)
            game.addVisual(new CooldownInterfaz(carta = c, posicion = c.posicionDelCooldown()))
            game.addVisual(new Tecla(carta = c))
        }
    }
}

object cartasMazoInGame {
    method mostrar() {
        var posiMazo = 1
        const x = 1
        var y = 13
        poro.mazo().forEach{ 
            carta => carta.asignarPosicion(game.at(x,y)) 
            game.addVisual(carta)
            game.addVisual(new CooldownInterfaz(carta = carta, posicion = game.at(x,y)))
            if (posiMazo == 1) {
                carta.tecla("Q")
            }
            if (posiMazo == 2){
                carta.tecla("W")
            }
            if (posiMazo == 3){
                carta.tecla("E")
            }
            if (posiMazo == 4){
                carta.tecla("R")
            }
            if (posiMazo == 5) {
                carta.tecla("T")
            }
            game.addVisual(new Tecla(carta = carta))
            y -= 3
            posiMazo += 1
        }
    }
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

// ----------COLECCIONES----------

object inventarioPrueba {
    method mostrarCartas() {
        game.clear()
        var x = 1
        var y = 12
        poro.coleccion().forEach{
            carta => carta.posicionEnColeccion(game.at(x,y)) 
            game.addVisual(carta) 
            if (x == 21) { x = 1 y -= 4 } // 1,12 ; 5,12 ; 9,12 ; 13,12 ; 17,12 ; 21,12 
            else { x += 4 }
            }
        game.addVisual(mensajeVolverAlMenu)
        keyboard.enter().onPressDo{menu.mostrarMenu()}
        }
        
    }



// ----------FONDOS----------

class Fondo {
    const imagen
    method image() = imagen
    method position() = game.at(0,0)
}

object fondoMenu inherits Fondo(imagen = "FondoMenu.png") {}

object fondoBatalla inherits Fondo(imagen = "FondoBatalla.png") {}

object fondoInstrucciones inherits Fondo(imagen = "FondoInstrcciones.png") {}


// EL DESASTRE
object inventario {
    method mostrarCartas() {
        game.clear()
        poro.coleccion().forEach{ c=>  // POR CADA CARTA DE LA COLECCION
        if (poro.coleccion().get(0) == c) { // 1
            c.posicionEnColeccion(game.at(1,12)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(1) == c) { // 2
            c.posicionEnColeccion(game.at(5,12)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(2) == c) { // 3
            c.posicionEnColeccion(game.at(9,12)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(3) == c) { // 4
            c.posicionEnColeccion(game.at(13,12)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(4) == c) { // 5
            c.posicionEnColeccion(game.at(17,12)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(5) == c) { // 6
            c.posicionEnColeccion(game.at(21,12)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(6) == c) { // 7
            c.posicionEnColeccion(game.at(1,8)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(7) == c) { // 8
            c.posicionEnColeccion(game.at(5,8)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(8) == c) { // 9
            c.posicionEnColeccion(game.at(9,8)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(9) == c) { // 10
            c.posicionEnColeccion(game.at(13,8)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(10) == c) { // 11
            c.posicionEnColeccion(game.at(17,8)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(11) == c) { // 12
            c.posicionEnColeccion(game.at(21,8)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(12) == c) { // 13
            c.posicionEnColeccion(game.at(1,4)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(13) == c) { // 14
            c.posicionEnColeccion(game.at(5,4)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(14) == c) { // 15
            c.posicionEnColeccion(game.at(9,4)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(15) == c) { // 16
            c.posicionEnColeccion(game.at(13,4)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(16) == c) { // 17
            c.posicionEnColeccion(game.at(17,4)) // LE SETEO LA POSICION A LA CARTA
        }
        if (poro.coleccion().get(17) == c) { // 18
            c.posicionEnColeccion(game.at(21,4)) // LE SETEO LA POSICION A LA CARTA
        }

        game.addVisual(c)
        }
        game.addVisual(mensajeVolverAlMenu)
        keyboard.enter().onPressDo{menu.mostrarMenu()}
    }
}