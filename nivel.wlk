import personajes.*
import cartas.*
import estadoCombate.*
import wollok.game.*

object nivelActual{
    method iniciar(nivel){
        poro.configurarNivel(nivel)

        if (nivel == 1){
            enemigoNivel1.configurar()
            estadoCombate.iniciarCombate(poro, enemigoNivel1)
        } else-if (nivel == 2){
            enemigoNivel2.configurar()
            estadoCombate.iniciarCombate(poro, enemigoNivel2)
        } else (nivel == 3){
            enemigoNivel3.configurar()
            estadoCombate.iniciarCombate(poro, enemigoNivel3)
        }
    }
}