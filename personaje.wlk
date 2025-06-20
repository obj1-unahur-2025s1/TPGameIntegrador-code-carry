import interfaz.*
import cartas.*
import juego.*
import nivel.*
import mazo.*
class Personaje {
  const property vidaInicial 
  var vida = vidaInicial
  var ataque 
  var defensa
  var turno 
  var enemigo
  const property coleccion = []
  const property esAD = true

  method noEsMiTurno() = game.say(self,"No es mi turno")

  method position()

  method vida() = vida
  method ataque() = ataque
  method defensa() = defensa

  method atacar() { 
    if (turno) {
      enemigo.recibirAtaque(self) 
      self.cambiarTurno() 
      }
    else {
      self.noEsMiTurno()
    }
  }

  method recibirAtaque(especie) { 
    game.removeVisual(danioInflijido)
    game.removeVisual(curacionTotal)
    self.cambiarTurno()
    const danioCompleto = if (!especie.esAD()) especie.poderMagico() * 1.3 - defensa else especie.ataque() - defensa * 0.2
    vida = (vida - danioCompleto).max(0).round()
    danioInflijido.posicionEnemigo(self.position())
    danioInflijido.corroborarDanio(danioCompleto)
    danioInflijido.tipo(especie)
    game.schedule(1000, { => game.addVisual(danioInflijido) })
    self.reducirCooldowns()
  }

  method puedoCurarme() = vida < vidaInicial

  method curarse() { 
    game.removeVisual(danioInflijido)
    game.removeVisual(curacionTotal)
    if (!turno) {
      self.noEsMiTurno()
    }
    else-if (vida == vidaInicial) {
      game.say(self, "Mi vida esta al maximo")
    }
    else-if (turno) {
      const curacion = vidaInicial - vida
      vida = vidaInicial 
      game.say(self, "CURACION")
      curacionTotal.posicionMia(self.position())
      curacionTotal.corroborarCuracion(curacion)
      game.schedule(1000, { => game.addVisual(curacionTotal) })
      self.cambiarTurno()
      enemigo.cambiarTurno()
      self.reducirCooldowns()
    }
  }

  method curarsePor(unaCarta) { 
    game.removeVisual(danioInflijido)
    var curazao = vidaInicial - vida 
    vida =  (vida + unaCarta.poderMagico() * 3).min(100)
    curacionTotal.posicionMia(self.position())
    curacionTotal.corroborarCuracion(curazao)
    game.schedule(1000, { => game.addVisual(curacionTotal) })
    enemigo.cambiarTurno()
    }

  method estaMuerto() = vida == 0

  method esSuTurno() = turno

  method cambiarTurno() { turno = !turno }

  method puedoUsarLaCarta(unaCarta) = unaCarta.cooldown() == 0

  method maximaVida() { vida = vidaInicial }

  // MAZO DE CARTAS POR NIVEL


  // COLECCION DE CARTAS

  method usarLaCarta(numero) { 
    const cartaAUsar = coleccion.get(numero - 1)
    if (turno and self.puedoUsarLaCarta(cartaAUsar)) {
      if (cartaAUsar.esDanio()) {
        cartaAUsar.atacarConCarta(enemigo)
        
      }
      else {
        cartaAUsar.curar(self)
      }
      self.cambiarTurno()
    }
    else-if(!turno) {
      self.noEsMiTurno()
    }
    else-if (cartaAUsar.tieneCooldown()) {
      cartaAUsar.mensajeCooldown()
    }
  }

  method reducirCooldowns() { 
    coleccion.forEach{c=>c.reducirCooldown()} 
    enemigo.coleccion().forEach{c=>c.reducirCooldown()} 
    }

  method agregarALaColeccion(unaCarta) { 
    if (!coleccion.contains(unaCarta)) {
      coleccion.add(unaCarta) 
      if (coleccion.size() == 1){
        unaCarta.asignarPrimeraPosicion()
      }
      if (coleccion.size() == 2) {
        unaCarta.asignarSegundaPosicion()
      }
      if (coleccion.size() == 3) {
        unaCarta.asignarTerceraPosicion()
      }
      if (coleccion.size() == 4) {
        unaCarta.asignarCuartaPosicion()
      }
      if(coleccion.size() == 5) {
        unaCarta.asignarQuintaPosicion()
      }
    }
  }

  method mezclarColeccion() { coleccion.randomized() }

  method reiniciarCooldowns() { coleccion.forEach{c=>c.reiniciarCooldown()} }

}

class PersonajeEnemigo inherits Personaje(turno = false, enemigo = poro) {
  const nombre
  override method position() = game.at(15,2)
  method nombre() = nombre
  override method recibirAtaque(danio) {
    super(danio)
    if (self.estaMuerto()){
      game.removeVisual(turnoDe)
      game.removeVisual(cartasInterfaz)
      game.addVisual(enemigoMuerto)
      game.addVisual(nivelCompletado)
      keyboard.enter().onPressDo{juego.subirDeNivel()}
    }
  }
  }

object poro inherits Personaje(vidaInicial = 100, ataque = 15, defensa = 25, turno = true, enemigo = juego.nivel().enemigo()){
  
  method image() = "poro-normal.png" 
  
  override method position() = game.at(6,2)

  method enemigoNuevo(nuevo) { enemigo = nuevo }
  
  override method recibirAtaque(danio) {
    super(danio)
    if (self.estaMuerto()){
      juego.reiniciarPartida()
    }
  }

}

object vacuolarva inherits PersonajeEnemigo(vidaInicial = 70, ataque = 10, defensa = 10, nombre = "Vacuolarva"){

  method image() = "larva-normal.png"


}

object enemigo2 inherits PersonajeEnemigo(vidaInicial = 80, ataque = 15, defensa = 10, nombre = "Enemigo 2"){

  method image() = "enemigo2.png"

}