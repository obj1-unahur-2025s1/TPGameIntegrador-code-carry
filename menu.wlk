import juego.*
import interfaz.*
import personaje.*

object menu {
    const opciones = [iniciarJuego, irAlInventario, irAInstrucciones, salir] // LISTA DE OPCIONES
    method mostrarMenu() {
        game.clear() // LIMPIA EL TABLERO
        poro.coleccion().forEach{c=>c.desasignarPosicion()} // DESASIGNA LAS CARTAS CADA VEZ QUE VUELVE AL MENU DESDE LA COLECCION
        // VISUALES
        game.addVisual(fondoMenu) // FONDO DEL MENU
        game.addVisual(iniciarJuego) // PRIMER OPCION = INICIAR PARTIDA
        game.addVisual(irAlInventario) // SEGUNDA OPCION = COLECCION
        game.addVisual(irAInstrucciones) // TERCERA OPCION = INSTRUCCIONES
        game.addVisual(salir) // CUARTA OPCION = SALIR
        //SELECCION
        keyboard.enter().onPressDo{self.elSeleccionado().entrar()} // AL TOCAR ENTER ENTRA A LA OPCION SELECCIONADA
        //TECLAS
        self.teclasDeMenu() // TECLAS ASIGNADAS = ARRIBA|ABAJO|ENTER
    }
    method elSeleccionado() = opciones.find{o=>o.estaSeleccionado()} // RETORNA LA OPCION SELECCIONADA

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
        keyboard.up().onPressDo{self.cambiarOpcionArriba()} // AL PRESIONAR {ARRIBA} SELECCIONA LA OPCION SUPERIOR
        keyboard.down().onPressDo{self.cambiarOpcionAbajo()} // AL PRESIONAR {ABAJO} SELECCIONA LA OPCION INFERIOR
    }
}


