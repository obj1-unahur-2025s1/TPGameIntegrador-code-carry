import nivel.*
import personaje.*
import juego.*
import menu.*
import sonido.*
import modelos.*

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
        cartasMazoInGamePoro.mostrar()
        cartasMazoInGameEnemigo.mostrar(juego.nivel().enemigo())
    }
}

// ----------PALETA DE COLORES----------

object paleta {
    const property blanco = "FFFFFF"
    const property rojo = "FF0000"
    const property verde = "00FF00"
    const property amarillo = "FFFF00"
    const property azul = "4290F5"
    const property violeta = "6100FF"
}

// ----------MENU----------

class Opcion {
    var estaSeleccionado
    method text() 
    method position() 
    method textColor() = if (self.estaSeleccionado()) paleta.violeta() else paleta.blanco() 
    method estaSeleccionado() = estaSeleccionado
    method cambiarSeleccion() { 
        sonidoDeMenu.iniciar()
        if (estaSeleccionado) estaSeleccionado = false 
        else estaSeleccionado = true }
    method entrar() {}
}

object iniciarJuego inherits Opcion(estaSeleccionado = true){
    override method text() = "NUEVA PARTIDA"
    override method position() = game.at(12,9)
    override method entrar() { juego.iniciarDe0() }
}

object irAlInventario inherits Opcion(estaSeleccionado = false) {
    override method text() = "COLECCION"
    override method position() = game.at(12,8)
    override method entrar() { inventarioPrueba.mostrarCartas() } // ESTOY TESTEANDO LA COLECCION
} 

object irAInstrucciones inherits Opcion(estaSeleccionado = false) {
    override method text() = "INSTRUCCIONES" 
    override method position() = game.at(12,7)
    override method entrar() { instrucciones.mostrar() }
}

object salir inherits Opcion(estaSeleccionado = false){
    override method text() = "SALIR"
    override method position() = game.at(12,6)
    override method entrar() { game.stop() }
}

object mensajeVolverAlMenu inherits Opcion(estaSeleccionado = false) {
    override method position() = game.at(12,1)
    override method text() = "Presione ENTER para volver al menu"
}

object instrucciones {
    method mostrar() {
        game.clear()
        game.addVisual(fondoInstrucciones)
        game.addVisual(menuInstrucciones)
        game.addVisual(mensajeVolverAlMenu)
        keyboard.enter().onPressDo{menu.iniciar()}
    }
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
    const color 
    method text() = "VIDA:" + personaje.vida().toString()
    method textColor() = if (personaje.vida() == 0) paleta.rojo() else color
    method position() = posicion

    method cambiar(nuevo) { personaje = nuevo }
}

const barraDePoro = new BarraDeVida(personaje = poro, posicion = game.at(7,1), color = paleta.blanco()) 

const barraDeEnemigo = new BarraDeVida(personaje = juego.nivel().enemigo(), posicion = game.at(17,1), color = paleta.violeta()) 

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
    method textColor() =paleta.rojo()
     
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
object cartasMazoInGamePoro {
    method mostrar() {
        var posiMazo = 1
        const x = 1
        var y = 13
        poro.mazo().forEach{ 
            carta => carta.asignarPosicion(game.at(x,y),posiMazo) 
            game.addVisual(carta)
            game.addVisual(new CooldownInterfaz(carta = carta))
            if (posiMazo == 1) {
                carta.tecla("Q")
                keyboard.q().onPressDo{poro.usarLaCarta(carta)}
            }
            if (posiMazo == 2){
                carta.tecla("W")
                keyboard.w().onPressDo{poro.usarLaCarta(carta)}
            }
            if (posiMazo == 3){
                carta.tecla("E")
                keyboard.e().onPressDo{poro.usarLaCarta(carta)}
            }
            if (posiMazo == 4){
                carta.tecla("R")
                keyboard.r().onPressDo{poro.usarLaCarta(carta)}
            }
            if (posiMazo == 5) {
                carta.tecla("T")
                keyboard.t().onPressDo{poro.usarLaCarta(carta)}
            }
            game.addVisual(new Tecla(carta = carta))
            y -= 3
            posiMazo += 1
        }
    }
}

object cartasMazoInGameEnemigo {
    method mostrar(enemigo) {
        const x = 21
        var y = 13
        enemigo.mazo().forEach{ 
            carta => carta.asignarPosicion(game.at(x,y),0) 
            game.addVisual(carta)
            game.addVisual(new CooldownInterfaz(carta = carta))
            y -= 3
        }
    }
}

class CooldownInterfaz {
    const carta
    method text() = if (carta.cooldown() != 0 ) carta.cooldown().toString() else ""
    method textColor() = paleta.blanco()
    method position() = game.at(carta.position().x()+1, carta.position().y() + 1)
}

class Tecla {
    const carta
    method text() = carta.tecla()
    method position() = game.at(carta.position().x()+2, carta.position().y()+2)
    method textColor() = paleta.blanco()
}

// ----------COLECCIONES----------

object inventarioPrueba {
    method mostrarCartas() {
        game.clear()
        game.addVisual(fondoMenu)
        var x = 1 
        var y = 12 // y = 8
        juego.todasLasCartas().forEach{
            carta => carta.posicionEnColeccion(game.at(x,y)) 
            game.addVisual(carta) 
            if (x == 21) { x = 1 y -= 4 } // 1,12 ; 5,12 ; 9,12 ; 13,12 ; 17,12 ; 21,12 
            else { x += 4 }
            }
        game.addVisual(mensajeVolverAlMenu)
        keyboard.enter().onPressDo{menu.iniciar()}
        }
    }
// ----------FONDOS----------

class Fondo {
    const imagen
    const x
    const y
    method image() = imagen
    method position() = game.at(x,y)
}


const fondoMenu = new Fondo(imagen="FondoMenu.png", x=0,y=0)
const fondoBatalla = new Fondo(imagen="FondoBatalla.png", x=0,y=0)
const fondoInstrucciones = new Fondo(imagen="FondoInstrcciones.png", x=0,y=0)
const logoMenu = new Fondo(imagen="logo.png", x=6,y=9)