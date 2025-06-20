import juego.*
import interfaz.*

object menu {
    method mostrarMenu() {
        game.clear()
        game.boardGround("fondoJuego.jpg")
        game.addVisual(menuCartel)
        keyboard.enter().onPressDo{juego.iniciar()}
    }
}

