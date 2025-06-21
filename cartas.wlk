import personaje.*
import interfaz.*
class Carta {
    const nombre
    var posicion = null
    var posicionCooldown = null
    var cooldown = 0
    var tecla = null
    const property esDanio 
    const property cooldownInicial
    const habilidad

    method image()
    method position() = posicion
    method tecla() = tecla
    method sonido()

    method posicionEnColeccion(nueva) { posicion = nueva }
    method cooldown() = cooldown
    method reducirCooldown() {cooldown = (cooldown - 1).max(0)}
    method reiniciarCooldown() { cooldown = 0 }
    method colocarCooldown() { cooldown = cooldownInicial }
    method tieneCooldown() = cooldown > 0
    method mensajeCooldown() = game.say(poro, "A la carta " + nombre + " le faltan " + cooldown + " turnos")

    method atacarConCarta(enemigo) {
        if (cooldown == 0) {
            self.sonidoEfecto(self.sonido())
            enemigo.recibirAtaque(self) 
            self.colocarCooldown() 
        }
        
        else {
            self.mensajeCooldown()
        }
    }
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

    // sonido 
    method sonidoEfecto(unSonido){
    const sonidoEfecto= new Sound(file = unSonido)
    sonidoEfecto.volume(1)
    sonidoEfecto.play()
  }
} 

class CartaAD inherits Carta {
    const property esAD = true
    const property ataque
    override method sonido()="Sonido-Carta-AD.mp3"


}

class CartaAP inherits Carta {
    const property esAD = false
    const property poderMagico
    override method sonido()="Sonido-Carta-AP.mp3"


}

class CartaSUPP inherits Carta {
     
    const property poderMagico
    override method sonido()="Sonido-Carta-Supp3.mp3"
    method curar(personaje) {
        if (cooldown == 0) {
            self.sonidoEfecto(self.sonido())
            personaje.curarsePor(self)
            self.colocarCooldown()
        }
        else {
            self.mensajeCooldown()
        }
    }
}

object garen inherits CartaAD(nombre = "Garen", cooldownInicial = 5, ataque = 40, habilidad = "null", esDanio = true) {
    override method image() = "garenfinal.png"
}

object ahri inherits CartaAP(nombre = "Ahri", cooldownInicial = 5, poderMagico = 50, habilidad = "null", esDanio = true) {
    override method image() = "ahrifinal.png"
}

object soraka inherits CartaSUPP(nombre = "Soraka", cooldownInicial = 10, poderMagico = 30, habilidad = "null", esDanio = false) {
    override method image() = "sorakafinal.png"
}

object draven inherits CartaAD(nombre = "Draven", cooldownInicial = 8, ataque = 50, habilidad = "null", esDanio = true) {
    override method image() = "dravenfinal.png"
}

object aatrox inherits CartaAD(nombre = "Aatrox", cooldownInicial = 3, ataque = 35, habilidad = "null", esDanio = true) {
    override method image() = "aatroxfinal.png"
}