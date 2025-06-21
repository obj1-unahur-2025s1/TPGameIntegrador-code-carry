import juego.*
import interfaz.*

object menu {
    method mostrarMenu() {
        game.clear()
        game.boardGround("fondoMenu.jpeg")
        game.addVisual(menuCartel)
        keyboard.enter().onPressDo{juego.iniciar()}
     //   keyboard.c().onPressDo{
     //       menuColecciones
      //      estadoColeccion.mostrar()}
        keyboard.i().onPressDo{
            menuInstrucciones
            estadoInstrucciones.mostrar()}
    }
}

object estadoInstrucciones {
    method mostrar() {
        game.clear()
        game.boardGround("fondoInstrucciones.jpeg")
        game.addVisual(menuInstrucciones)
        keyboard.enter().onPressDo{ menu.mostrarMenu()}
    }
}

//object estadoColeccion {
//    method mostrar() {
//      game.clear()
//        game.addVisual(menuColecciones)
//        keyboard.enter().onPressDo{ menu.mostrarMenu()}
//    }
//}
