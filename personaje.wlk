import interfaz.*
import cartas.*
import juego.*
import nivel.*
import sonido.*
import modelos.*

class Personaje {
  const vidaInicial 
  const ataque 
  const defensa
  const sonidoAtaque
  const imagen 
  const posicion
  var turno 
  var enemigo

  var vida = vidaInicial
  const property coleccion = []
  const property mazo = []

  method noEsMiTurno() = game.say(self,"No es mi turno")

  method position() = posicion

  method vida() = vida
  method ataque() = ataque
  method defensa() = defensa
  method atacar() { 
    if (turno) {
      enemigo.recibirAtaque(self) 
      self.cambiarTurno() 
      self.sonidoAtaque().play()
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
    danioInflijido.corroborarDanio(danioCompleto.round())
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
    else {
      // CUENTA CURACION
      const curacion = vidaInicial * 0.1 
      // LO CURA
      vida = vida + vidaInicial  *  0.1
      game.say(self, "CURACION")
      sonidoDeHeal.iniciar()
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
    const curazao = vidaInicial - vida 
    vida =  ( vida + unaCarta.poderMagico() * 3 ).min(100)
    curacionTotal.posicionMia(self.position())
    curacionTotal.corroborarCuracion(curazao)
    game.schedule( 1000, { => game.addVisual(curacionTotal) } )
    enemigo.cambiarTurno()
    poro.reducirCooldowns()
    }

  method estaMuerto() = vida == 0

  method esSuTurno() = turno

  method cambiarTurno() { turno = !turno }

  method maximaVida() { vida = vidaInicial }

  method usarLaCarta(carta) { 
    if (turno and self.puedoUsarLaCarta(carta)) {
      carta.usar(self)
      self.cambiarTurno()
      self.reducirCooldowns()
    }
    else-if (!turno) { self.noEsMiTurno() }
    else-if (carta.tieneCooldown()) { carta.mensajeCooldown() }
  }

  // COLECCION DE CARTAS

  method reducirCooldowns() { mazo.forEach{ c=>c.reducirCooldown() } }

  method llenarMazo(unaCantidad) { coleccion.randomized().forEach{c=> if (mazo.size() < unaCantidad) self.agregarAlMazo(c) } } 

  method agregarALaColeccion(unaCarta) { if (!coleccion.contains(unaCarta)) coleccion.add(unaCarta) } 

  method limpiarMazo() { mazo.clear() }

  method puedoUsarLaCarta(unaCarta) = unaCarta.cooldown() == 0

  method agregarAlMazo(unaCarta) { mazo.add(unaCarta) }

  method desasignarCartas() { coleccion.forEach{c=>c.desasignarPosicion()} mazo.forEach{c=>c.desasignarPosicion()}}

  method reiniciarCooldowns() { coleccion.forEach{c=>c.reiniciarCooldown()} }

  // ----  SONIDO  ----

  method sonidoAtaque() = sonidoAtaque
  method image() = imagen
  method enemigo() = enemigo
}

class PersonajeEnemigo inherits Personaje(turno = false, enemigo = poro) {
  const property nombre
  const property sonidoAparicion
  
  override method recibirAtaque(danio) {
    super(danio)
    game.schedule(2800,{self.contestar()})
    if (self.estaMuerto()){
      game.removeVisual(turnoDe)
      game.removeVisual(cartasMazoInGamePoro)
      game.addVisual(enemigoMuerto)
      game.addVisual(nivelCompletado)
      keyboard.enter().onPressDo{juego.subirDeNivel()}
    }
  }

  method contestar(){
    if(turno){
      if (vidaInicial * 0.10 > vida) self.curarse()
      else self.usarUnaCarta()
    }
  }

  method usarUnaCarta() { mazo.forEach{ carta=> self.usarLaCarta(carta)} }
}

class PersonajePrincipal inherits Personaje(
    vidaInicial = 750, 
    ataque = 25, 
    defensa = 25, 
    turno = true, 
    sonidoAtaque = sonidoAtaquePoro,
    imagen = "poro-normal.png",
    enemigo = juego.nivel().enemigo(),
    posicion = game.at(6,2)
    ) {

  method enemigoNuevo(nuevo) { enemigo = nuevo }
  
  override method recibirAtaque(danio) {
    super(danio)
    if (self.estaMuerto()){
      juego.reiniciarPartida()
    }
  }

  override method curarse() {
    super()
    game.schedule(2800,{enemigo.contestar()})
  }
}


