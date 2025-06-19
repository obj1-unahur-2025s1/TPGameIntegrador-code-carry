import wollok.game.*
import cartas.*
import visuales.*
import juego.*
import estadoMenu.* 

object estadoInstrucciones {
    method mostrar() {
        game.clear()
        game.addVisual(cartelNivel)
        game.say(cartelNivel, "INSTRUCCIONES")
        game.say(cartelNivel, "- ¡Recupera tus Porogalletas!")
        game.say(cartelNivel, "- El juego es por turnos y se juega con cartas (Q/W/E/R/T).")
        game.say(cartelNivel, "- Cada carta tiene un cooldown y efecto especial.")
        game.say(cartelNivel, "- Peleas en niveles contra: Larva del Vacio, Heraldo de la Grieta y Baron Nashor.")
        game.say(cartelNivel, "- Si ganas los 3, recuperas tus Porogalletas.")
        game.say(cartelNivel, "- Si pierdes, podes reintentar una vez mas el nivel.")
        game.say(cartelNivel, "- Si pierdes tus intentos, vuelves a comenzar de cero.")
        game.say(cartelNivel, "ENTER para vovler al menu")
        keyboard.enter().onPressDo{ estadoMenu.mostrarMenu()}
    }

    method usarCartaEnTurno(indice) {}
    method continuar() {self.mostrar()}
}

object estadoColeccion {
    method mostrar() {
      game.clear()
        game.addVisual(cartelNivel)
        game.say(cartelNivel, "COLECCION DE CARTAS DISPONIBLES:")
        cartasDisponibles.todasLasCartas.forEach({carta =>
            game.say(cartelNivel, "-" + carta.nombre()+ ":" + carta.descripcion())})
        game.say(cartelNivel, "ENTER para vovler al menu")
        keyboard.enter().onPressDo{ estadoMenu.mostrarMenu()}
    }

    method usarCartaEnTurno(indice) {}
    method continuar() {self.mostrar()} 
}