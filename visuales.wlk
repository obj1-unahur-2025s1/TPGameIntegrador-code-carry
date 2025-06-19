import wollok.game.*
import estadoMenu.*
import estadoCombate.*
import juego.*


object cartelNivel {
    method position() = game.at(10,6)
    method imagen() = ""
}

object cartelResultado{
    method position() = game.at(20,20)
    method imagen() = ""
}

object jugador{
    method position() = game.at(10,25)
    method imagen() = ""
}

object enemigo{
    method position() = game.at(35,10)
    method imagen() = ""
}

object poroAtacando{
    method position() = game.at(15,25)
    method imagen() = ""
}

object poroDañado{
    method position() = game.at(15,25)
    method imagen() = ""
}

object enemigoAtacandoNivel1{
    method position() = game.at(35,10)
    method imagen() = ""
}

object enemigoDañadoNivel1{
    method position() = game.at(35,10)
    method imagen() = ""
}

object enemigoAtacandoNivel2{
    method position() = game.at(35,10)
    method imagen() = ""
}

object enemigoDañadoNivel2{
    method position() = game.at(35,10)
    method imagen() = ""
}


object enemigoAtacandoNivel3{
    method position() = game.at(35,10)
    method imagen() = ""
}

object enemigoDañadoNivel3{
    method position() = game.at(35,10)
    method imagen() = ""
}

object estadoExtras {
    method mostrarEnemigoDañado() {
        if (juego.nivelActual() == 1) game.addVisual(enemigoDañadoNivel1)
        else if (juego.nivelActual() == 2) game.addVisual(enemigoDañadoNivel2)
        else game.addVisual(enemigoDañadoNivel3)
    }

    method mostrarEnemigoAtacando() {
        if (juego.nivelActual() == 1) game.addVisual(enemigoAtacandoNivel1)
        else if (juego.nivelActual() == 2) game.addVisual(enemigoAtacandoNivel2)
        else game.addVisual(enemigoAtacandoNivel3)
    }
}