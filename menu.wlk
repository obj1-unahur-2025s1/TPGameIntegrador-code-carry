import sonido.*
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
        if (iniciarJuego.estaSeleccionado()) { // Si la primera opcion es verdadera
            iniciarJuego.cambiarSeleccion() // Iniciar juego cambia a false
            salir.cambiarSeleccion() // Salir cambia a true
        }
        else-if (irAlInventario.estaSeleccionado()) { // Si la segunda opcion es verdadera
            irAlInventario.cambiarSeleccion() // Coleccion cambia false
            iniciarJuego.cambiarSeleccion() // Iniciar cambia a true
        }
        else-if (irAInstrucciones.estaSeleccionado()) { // Si la tercera opcion es verdader
            irAInstrucciones.cambiarSeleccion() // Instrucciones cambia a false 
            irAlInventario.cambiarSeleccion() // Coleccion cambia a true
        }
        else { // Sino por descarte, salir esta en verdadero
            salir.cambiarSeleccion() // salir cambia a false
            irAInstrucciones.cambiarSeleccion() // Instrucciones cambia a true
        }
       
        
    }

    method cambiarOpcionAbajo() {
        if (iniciarJuego.estaSeleccionado()) { // Si iniciar juego esta en verdadero
            iniciarJuego.cambiarSeleccion() // Iniciar juego cambia a false
            irAlInventario.cambiarSeleccion() // Inventario cambia a true
        }
        else-if (irAlInventario.estaSeleccionado()) { // Si coleccion esta en verdadero 
            irAlInventario.cambiarSeleccion() // Coleccion cambia a false 
            irAInstrucciones.cambiarSeleccion() // Instruccion cambia a true 
        }
        else-if (irAInstrucciones.estaSeleccionado()) { // Si instruccion esta en verdadero
            irAInstrucciones.cambiarSeleccion() // Instrucciones cambia a false
            salir.cambiarSeleccion() // Salir cambia a true  
        }
        else { // Por descarte salir esta en verdadero
            salir.cambiarSeleccion() // Salir cambia a falso
            iniciarJuego.cambiarSeleccion() // Iniciar juego cambia a true
            
        }
        
       
    }

    method teclasDeMenu() {
        keyboard.up().onPressDo{self.cambiarOpcionArriba() } // AL PRESIONAR {ARRIBA} SELECCIONA LA OPCION SUPERIOR
        keyboard.down().onPressDo{self.cambiarOpcionAbajo() } // AL PRESIONAR {ABAJO} SELECCIONA LA OPCION INFERIOR
    }
}


