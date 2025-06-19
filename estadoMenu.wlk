import estadoInstrucciones.*
import wollok.game.*
import nivel.*
import juego.*
import estadoCombate.*
import visuales.*
import personajes.*

object estadoMenu{
    method mostrarMenu(){
        game.clear()
        game.boardGround("")
        game.addVisual(cartelNivel)
        game.say(cartelNivel, "Presiona ENTER para comenzar")
        game.say(cartelNivel, "Presiona C para ver coleccion")
        game.say(cartelNivel, "Presiona I para ver instrucciones")

        keyboard.enter().onPressDo{juego.inicio()}
        keyboard.c().onPressDo{
            juego.estado(estadoColeccion)
            estadoColeccion.mostrar()}
        keyboard.i().onPressDo{
            juego.estado(estadoInstrucciones)
            estadoInstrucciones.mostrar()}
    }

    method usarCartaEnTurno(indice){}
    method continuar(){self.mostrarMenu()}
}