import personaje.*
import interfaz.*
class Carta {
    const nombre
    var posicion = null // Al colocarlo vacio, al crear una carta me piden una posicion y no deberia tener una predefinida
    var posicionCooldown = null // Al colocarlo vacio, al crear una carta me piden una posicion y no deberia tener una predefinida
    var tecla = null // Al colocarlo vacio, al crear una carta me piden una tecla y no deberia tener una predefinida
    var cooldown = 0
    const property esDanio // Para saber si es una carta de ataque o una de curacion
    const property cooldownInicial 
    const habilidad 

    method image()
    method position() = posicion
    method tecla() = tecla

    method posicionEnColeccion(nueva) { posicion = nueva }

    // ----  COOLDOWNS  ----
    method cooldown() = cooldown
    method reducirCooldown() {cooldown = (cooldown - 1).max(0)}
    method reiniciarCooldown() { cooldown = 0 }
    method colocarCooldown() { cooldown = cooldownInicial }
    method tieneCooldown() = cooldown > 0
    method mensajeCooldown() = game.say(poro, "A la carta " + nombre + " le faltan " + cooldown + " turnos")

    // ----  POSICIONES  ----
    method desasignarPosicion() {
        posicion = null
        tecla = null
        posicionCooldown = null
    }

    method asignarPrimeraPosicion() { 
        tecla = "Q"
        posicion = posicionUno.posicionCarta()
        posicionCooldown = posicionUno.posicionCooldown()
    }

    method asignarSegundaPosicion() {
        tecla = "W"
        posicion = posicionDos.posicionCarta()
        posicionCooldown = posicionDos.posicionCooldown()
    }

    method asignarTerceraPosicion() {
        tecla = "E"
        posicion = posicionTres.posicionCarta()
        posicionCooldown = posicionTres.posicionCooldown()
    }

    method asignarCuartaPosicion() {
        tecla = "R"
        posicion = posicionCuatro.posicionCarta()
        posicionCooldown = posicionCuatro.posicionCooldown()
    }

    method asignarQuintaPosicion() {
        tecla = "T"
        posicion = posicionCinco.posicionCarta()
        posicionCooldown = posicionCinco.posicionCooldown()
    }

    method posicionDelCooldown() = posicionCooldown

    // ----  SONIDO  ---
    method sonidoEfecto(unSonido){
    const sonidoEfecto= new Sound(file = unSonido)
    sonidoEfecto.volume(1)
    sonidoEfecto.play()
  }
} 

class CartaDanio inherits Carta(esDanio = true) {
    method sonidoAtaque()
    method atacarConCarta(enemigo) {
        if (cooldown == 0) {
            enemigo.recibirAtaque(self)
            self.sonidoAtaque().play()
            self.colocarCooldown() 
        }
        
        else {
            self.mensajeCooldown()
        }
    }
}

class CartaAD inherits CartaDanio {
    const property esAD = true
    const property ataque
    override method sonidoAtaque()= new Sound(file = "Sonido-Carta-AD.mp3")
}

class CartaAP inherits CartaDanio {
    const property esAD = false
    const property poderMagico
    override method sonidoAtaque()=new Sound(file = "Sonido-Carta-AP.mp3")
}

class CartaSUPP inherits Carta(esDanio = false) {
     
    const property poderMagico
    method sonidoCuracion()= new Sound(file = "Sonido-Carta-Supp3.mp3")
    method curar(personaje) {
        if (cooldown == 0) {
            personaje.curarsePor(self)
            self.sonidoCuracion().play()
            self.colocarCooldown()
        }
        else {
            self.mensajeCooldown()
        }
    }
}

object garen inherits CartaAD(nombre = "Garen", cooldownInicial = 5, ataque = 40, habilidad = "null") {
    override method image() = "garenfinal.png"
}

object ahri inherits CartaAP(nombre = "Ahri", cooldownInicial = 5, poderMagico = 50, habilidad = "null") {
    override method image() = "ahrifinal.png"
}

object soraka inherits CartaSUPP(nombre = "Soraka", cooldownInicial = 10, poderMagico = 30, habilidad = "null") {
    override method image() = "sorakafinal.png"
}

object draven inherits CartaAD(nombre = "Draven", cooldownInicial = 8, ataque = 50, habilidad = "null") {
    override method image() = "dravenfinal.png"
}

object aatrox inherits CartaAD(nombre = "Aatrox", cooldownInicial = 3, ataque = 35, habilidad = "null") {
    override method image() = "aatroxfinal.png"
}