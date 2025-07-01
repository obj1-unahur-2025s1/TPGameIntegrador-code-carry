import personaje.*
import interfaz.*
import sonido.*
import modelos.*

class Carta {
    const nombre
    const property cooldownInicial 
    const property sonido
    const imagen

    var indice = null
    var posicion = null // Al colocarlo vacio, al crear una carta me piden una posicion y no deberia tener una predefinida
    var posicionCooldown = null // Al colocarlo vacio, al crear una carta me piden una posicion y no deberia tener una predefinida
    var property tecla = null // Al colocarlo vacio, al crear una carta me piden una tecla y no deberia tener una predefinida
    var cooldown = 0

    method image() = imagen
    method position() = posicion

    method posicionEnColeccion(nueva) { posicion = nueva }

    // ----  COOLDOWNS  ----
    method cooldown() = cooldown
    method reducirCooldown() { cooldown = (cooldown -1).max(0) } 
    method reiniciarCooldown() { cooldown = 0 }
    method colocarCooldown() { cooldown = cooldownInicial }
    method tieneCooldown() = cooldown > 0
    method mensajeCooldown() = game.say(poro, "A la carta " + nombre + " le faltan " + cooldown + " turnos")

    // ----  POSICIONES  ----

    method desasignarPosicion() { 
        posicion = null
        tecla = null
        posicionCooldown = null
        indice = null
    }

    method asignarPosicion(unaPosicion,indiceNuevo) {
        posicion = unaPosicion
        posicionCooldown = unaPosicion
        indice = indiceNuevo
    }

    // ----  SONIDO  ---
    method sonidoEfecto(unSonido){
        const sonidoEfecto= new Sound(file = unSonido)
        sonidoEfecto.volume(1)
        sonidoEfecto.play()
    }
    method usar(target) 
} 

class CartaDanio inherits Carta {
    
}

class CartaSUPP inherits CartaAP(sonido = sonidoCartaCuracion) {
    override method usar(target) {
        if (cooldown == 0) {
            target.curarsePor(self)
            sonido.play()
            self.colocarCooldown()
        }
        else {
            self.mensajeCooldown()
        }
    }
}

class CartaAD inherits CartaDanio(sonido = sonidoCartaDanio) { 
    const property ataque 
    override method usar(target) {
        if (cooldown == 0) {
            target.enemigo().recibirAtaque(ataque)
            //sonidoCartaDanio.play()
            self.colocarCooldown() 
        }
        else {
            self.mensajeCooldown()
        }
    }
}

class CartaAP inherits CartaDanio(sonido = sonidoCartaMagia) { 
    const property poderMagico 
    override method usar(target) {
        if (cooldown == 0) {
            target.enemigo().recibirAtaque(poderMagico * 1.3)
            //sonidoCartaMagia.play()
            self.colocarCooldown() 
        }
        else {
            self.mensajeCooldown()
        }
    }
    }