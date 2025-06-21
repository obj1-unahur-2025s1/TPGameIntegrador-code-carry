import juego.*
import interfaz.*
import personaje.*

object menu {
    const opciones = [iniciarJuego, irAlInventario, irAInstrucciones, salir]
    method mostrarMenu() {
        game.clear()
        poro.coleccion().forEach{c=>c.desasignarPosicion()}
        // VISUALES
        game.boardGround("fondoMenu.jpeg")
        game.addVisual(iniciarJuego)
        game.addVisual(irAlInventario)
        game.addVisual(irAInstrucciones)
        game.addVisual(salir)
        //SELECCION
        keyboard.enter().onPressDo{self.elSeleccionado().entrar()}
        //TECLAS
        self.teclasDeMenu()
    }

    method elSeleccionado() = opciones.find{o=>o.estaSeleccionado()}

    method cambiarOpcionArriba() {
        if (iniciarJuego.estaSeleccionado()) {
            iniciarJuego.cambiarSeleccion()
            salir.cambiarSeleccion()
        }
        else-if (irAlInventario.estaSeleccionado()) {
            irAlInventario.cambiarSeleccion()
            iniciarJuego.cambiarSeleccion()
        }
        else-if (irAInstrucciones.estaSeleccionado()) {
            irAInstrucciones.cambiarSeleccion()
            irAlInventario.cambiarSeleccion()
        }
        else {
            salir.cambiarSeleccion()
            irAInstrucciones.cambiarSeleccion()
        }
    }

    method cambiarOpcionAbajo() {
        if (iniciarJuego.estaSeleccionado()) {
            iniciarJuego.cambiarSeleccion()
            irAlInventario.cambiarSeleccion()
        }
        else-if (irAlInventario.estaSeleccionado()) {
            irAlInventario.cambiarSeleccion()
            irAInstrucciones.cambiarSeleccion()
        }
        else-if (irAInstrucciones.estaSeleccionado()) {
            irAInstrucciones.cambiarSeleccion()
            salir.cambiarSeleccion()
        }
        else {
            salir.cambiarSeleccion()
            iniciarJuego.cambiarSeleccion()
        }
    }

    method teclasDeMenu() {
        keyboard.up().onPressDo{self.cambiarOpcionArriba()}
        keyboard.down().onPressDo{self.cambiarOpcionAbajo()}
    }
}


