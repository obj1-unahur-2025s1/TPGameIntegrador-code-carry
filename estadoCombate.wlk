import estadoInstrucciones.*
import wollok.game.*
import personajes.*
import nivel.*
import estadoMenu.*
import visuales.*
import cartas.*
import juego.*


object estadoCombate{
    var turnoJugador = true

    method iniciarCombate(jugador, enemigo){
        juego.jugador(jugador)
        juego.enemigo(enemigo)
        turnoJugador = true
        self.mostrarTurno()
    }

    method mostrarTurno(){
        game.clear()
        game.boardGround("")
        game.addVisual(jugador)
        game.addVisual(enemigo)

        game.say(jugador, "Tu vida:" + juego.jugador.vida().toString())
        game.say(enemigo, "Vida enemiga:" + juego.enemigo.vida().toString())
        game.say(cartelNivel, "Nivel" + juego.nivelActual.toString() + " /3")

        if (turnoJugador){
            game.say(jugador, "Presiona Q/W/E/R/T para usar cartas")
        }else{
           game.schedule(1000, {=>
            var carta = juego.enemigo.cartas().randomize()
            if (carta != null){
                estadoExtras.mostrarEnemigoAtacando()   
                game.schedule(500, {
                    carta.usarSobre(juego.jugador, juego.enemigo)
                    juego.enemigo.aplicarCooldown(carta)
                    game.addVisual(poroDañado)
                })
            }
            game.schedule(1000, {self.cambiarTurno()})
           })
        }
    }

    method usarCartaEnTurno(indice){
        var carta = juego.jugador.cartas().getOrElse(indice, null)
        if (carta != null and juego.jugador.puedeUsar(carta)){
            game.addVisual(poroAtacando)
            game.schedule(500, {
                carta.usarSobre(juego.enemigo, juego.jugador)
                juego.jugador.aplicarCooldown(carta)
                estadoExtras.mostrarEnemigoDañado()
            })
            game.schedule(1000, {self.cambiarTurno()})
        }
    }

    method cambiarTurno(){
        turnoJugador = !turnoJugador
        juego.jugador.reducirCooldowns()
        juego.enemigo.reducirCooldowns()
        self.verificarEstado()
    }

    method verificarEstado(){ 
        if (juego.jugador.estaMuerto()) {
            self.procesarDerrota()
        } else-if (juego.enemigo.estaMuerto()){
            self.procesarVictoria()
        } else {
            self.mostrarTurno()
        }
    } 

    method procesarDerrota() {
        juego.intentosFallidos(1)
        game.clear()
        game.addVisual(cartelResultado)

        if (juego.intentosFallidos == 1){
            game.say(cartelResultado, "¡Perdiste! Presiona ENTER para reiniciar el nivel")
            keyboard.enter().onPressDo{
                nivelActual.iniciar(juego.nivelActual())
            }
        } else {
            game.say(cartelResultado, "¡Perdiste nuevamente! Volviendo al menu..")
            keyboard.enter().onPressDo{
                juego.nivelActual(1)
                juego.intentosFallidos(0)
                juego.estado(estadoMenu)
                estadoMenu.mostrarMenu() 
            }
        }
    }

    method procesarVictoria() {
        game.clear()
        game.addVisual(cartelResultado)

        if (juego.nivelActual == 3){
            game.say(cartelResultado, "¡Ganaste el juego! Presiona ENTER para volver al menu")
            keyboard.enter().onPressDo{
                juego.nivelActual(1)
                juego.intentosFallidos(0)
                juego.estado(estadoMenu)
                estadoMenu.mostrarMenu()
            }
        } else {
            game.say(cartelResultado, "¡Victoria! Presiona ENTER para avanzar al siguiente nivel")
            keyboard.enter().onPressDo{
                juego.nivelActual() + 1 
                nivelActual.iniciar(nivelActual) 
            }
        }
    }

    method continuar(){
        self.mostrarTurno()
    }
}
