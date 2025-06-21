import juego.*
import interfaz.*

object menu {
    method mostrarMenu() {
        game.clear()
        game.boardGround("fondoJuego.jpg")
        game.addVisual(menuCartel)
        game.addVisual(irAlInventario)
        keyboard.enter().onPressDo{juego.iniciar()}
        keyboard.i().onPressDo{coleccionDeCartas.mostrarColeccion()}
    }
}

object coleccionDeCartas {
    method mostrarColeccion() {
        game.clear()
        coleccionDeCartasInterfaz.mostrarCartas()
        game.addVisual(volverAlMenu)
        keyboard.m().onPresDo{menu.mostrarMenu()}
    }
}

