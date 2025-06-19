import cartas.*

class Personaje{
    var property vida 
    var property vidaMax 
    var property dañoFisico 
    var property dañoMagico 
    var property dañoAtaque 
    var property armadura 
    var property curacion 
    var perderTurno = false
    var cartas = []
    var cooldowns = []

    method puedeUsar(carta){
        cooldowns.getOrElse(carta, 0) == 0
    }
    method aplicarCooldown(carta){
        cooldowns.put(carta, Carta.cooldown) 
    }
    method reducirCooldowns(){
        cooldowns.keys().forEach({carta => cooldowns.put(carta,(cooldowns.get(carta)-1).max(0))})
    }
    method reiniciarCooldowns(){
        cooldowns = []
        cartas.forEach({carta => cooldowns.put(carta, 0)})
    }
    method recibirDaño(cantidad){
        vida -= (cantidad - armadura).max(0)
        if (vida < 0) vida = 0
    }
    method estaMuerto(){vida <= 0}

    method asignarCartas(n){
        cartas = cartasDisponibles.alAzar(n)
        self.reiniciarCooldowns()
    }
    method aumentarDañoFisico(porcentaje){
        dañoFisico *= (1 + porcentaje)
    }
    method aumentarDañoAtaque(porcentaje){
        dañoAtaque *= (1 + porcentaje)
    }
    method aumentarDañoMagico(porcentaje){
        dañoMagico *= (1 + porcentaje)
    }
    method aumentarCuracion(porcentaje){
        curacion *= (1 + porcentaje)
    }
    method aumentarArmadura(porcentaje){
        armadura *= (1 + porcentaje)
    }
    method curarPor(porcentaje){
        const cantidad = vidaMax * porcentaje // porque le gusta que sea const(?)
        vida = (vida + cantidad).min(vidaMax)
    }
    method aniquilarSiVidaMenorA(porcentaje){
        if (vida / vidaMax <= porcentaje){
            vida = 0
        }
    }
    method aturdir(){perderTurno = true}
}

object poro inherits Personaje( vida = 750,
     vidaMax = 750,
     dañoFisico = 150,
     dañoMagico = 100,
     dañoAtaque = 100,
     armadura = 60,
     curacion = 0){

    method configurarNivel(nivel){
        if (nivel == 1) {
            vida = 750
            vidaMax = 750
            dañoFisico = 150
            dañoMagico = 100
            dañoAtaque = 100
            armadura = 60
            curacion = 0
            self.asignarCartas(3)
        } else-if (nivel ==2){
            vida = 1500
            vidaMax = 1500
            dañoFisico = 300
            dañoMagico = 200
            dañoAtaque = 200
            armadura = 120
            curacion = vidaMax * 0.05
            self.asignarCartas(5)
        } else (nivel == 3){ //hace alta que le ponga (nivel==3) ? 
            vida = 3000
            vidaMax = 3000
            dañoFisico = 600
            dañoMagico = 400
            dañoAtaque = 400
            armadura = 240
            curacion = vidaMax * 0.10
            self.asignarCartas(5)
        }
    }
}

object enemigoNivel1 inherits Personaje(vida = 800,
    vidaMax = 800,
    dañoFisico = 150,
    dañoMagico = 100,
    dañoAtaque = 100,
    armadura = 0,
    curacion = 0.1){

    method configurar(){
        self.asignarCartas(3)
    }
}

object enemigoNivel2 inherits Personaje(vida = 2000,
    vidaMax = 2000,
    dañoFisico = 300,
    dañoMagico = 250,
    dañoAtaque = 200,
    armadura = 150,
    curacion = 0.2){
    
    method configurar(){
        self.asignarCartas(5)
    }
}

object enemigoNivel3 inherits Personaje(vida = 5000,
    vidaMax = 5000,
    dañoFisico = 650,
    dañoMagico = 450,
    dañoAtaque = 500,
    armadura = 300,
    curacion = 0.3){

    method configurar(){
        self.asignarCartas(5)
    }
}