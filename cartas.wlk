import personaje.*
import interfaz.*
class Carta {
    const nombre
    var posicion = null // Al colocarlo vacio, al crear una carta me piden una posicion y no deberia tener una predefinida
    var posicionCooldown = null // Al colocarlo vacio, al crear una carta me piden una posicion y no deberia tener una predefinida
    var property tecla = null // Al colocarlo vacio, al crear una carta me piden una tecla y no deberia tener una predefinida
    var cooldown = 0
    const property esDanio // Para saber si es una carta de ataque o una de curacion
    const property cooldownInicial 
    const habilidad 

    method image()
    method position() = posicion

    method posicionEnColeccion(nueva) { posicion = nueva }

    // ----  COOLDOWNS  ----
    method cooldown() = cooldown
    method reducirCooldown() { 
        if (cooldown > 0) {
            cooldown -= 1
        }
    }
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

    method asignarPosicion(unaPosicion) {
        posicion = unaPosicion
        posicionCooldown = unaPosicion
    }
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

object garen inherits CartaAD(nombre = "Garen", cooldownInicial = 5, ataque = 70, habilidad = "null") {
    override method image() = "garenfinal.png"
}

object ahri inherits CartaAP(nombre = "Ahri", cooldownInicial = 5, poderMagico = 80, habilidad = "null") {
    override method image() = "ahrifinal.png"
}

object soraka inherits CartaSUPP(nombre = "Soraka", cooldownInicial = 10, poderMagico = 40, habilidad = "null") {
    override method image() = "sorakafinal.png"
}

object draven inherits CartaAD(nombre = "Draven", cooldownInicial = 8, ataque = 70, habilidad = "null") {
    override method image() = "dravenfinal.png"
}

object aatrox inherits CartaAD(nombre = "Aatrox", cooldownInicial = 3, ataque = 65, habilidad = "null") {
    override method image() = "aatroxfinal.png"
}

object alistar inherits CartaAP(nombre = "Alistar", cooldownInicial = 5, poderMagico = 50, habilidad = "null") {
    override method image() = "alistarfinal.png"
} 

object amumu inherits CartaAD(nombre = "Amumu", cooldownInicial = 3, ataque = 45, habilidad = "null") {
    override method image() = "amumufinal.png"
}

object aurelion inherits CartaAP(nombre = "Aurelion", cooldownInicial = 5, poderMagico = 45, habilidad = "null") {
    override method image() = "aurelionfinal.png"
} 

object blitz inherits CartaAP(nombre = "Blitz", cooldownInicial = 4, poderMagico = 40, habilidad = "null") {
    override method image() = "blitzfinal.png"
}

object brand inherits CartaAP(nombre = "Brand", cooldownInicial = 5, poderMagico = 35, habilidad = "null") {
    override method image() = "brandfinal.png"
}

object camille inherits CartaAD(nombre = "Camille", cooldownInicial = 6, ataque = 50, habilidad = "null") {
    override method image() = "camillefinal.png"
}

object fiora inherits CartaAD(nombre = "Fiora", cooldownInicial = 3, ataque = 35, habilidad = "null") {
    override method image() = "fiorafinal.png"
} 

object ashe inherits CartaAD(nombre = "Ashe", cooldownInicial = 4, ataque = 70, habilidad = "null") {
    override method image() = "ashefinal.png"
}

object jhin inherits CartaAD(nombre = "Jhin", cooldownInicial = 4, ataque = 74, habilidad = "null") {
    override method image() = "jhinfinal.png"
} 

object karma inherits CartaAP(nombre = "Karma", cooldownInicial = 4, poderMagico = 75, habilidad = "null") {
    override method image() = "karmafinal.png"
} 

object morgana inherits CartaAP(nombre = "Morgana", cooldownInicial = 5, poderMagico = 80, habilidad = "null") {
    override method image() = "morganafinal.png"
}

object nasus inherits CartaAD(nombre = "Nasus", cooldownInicial = 3, ataque = 70, habilidad = "null") {
    override method image() = "nasusfinal.png"
} 

object pyke inherits CartaAD(nombre = "Pyke", cooldownInicial = 10, ataque = 75, habilidad = "null") {
    override method image() = "pykefinal.png"
} 
