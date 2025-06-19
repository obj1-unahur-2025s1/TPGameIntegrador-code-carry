import personajes.*

class Carta{
  var property nombre
  var property descripcion
  var property cooldown

  method usarSobre(objetivo, usuario){}
}

object cartasDisponibles{
  const todasLasCartas= [aatrox, ahri]

  method alAzar(cantidad){
    return todasLasCartas.randomize().take(cantidad)
  }
}

object aatrox inherits Carta(nombre = "Aatrox", 
  descripcion = "Aumenta su daño de ataque, curación y daño físico", 
  cooldown = 2){
 
  override method usarSobre(objetivo, usuario){
    usuario.aumentarDañoFisico(0.10)
    usuario.aumentarDañoAtaque(0.15)
    usuario.aumentarCuracion(0.10)
  }
}

object ahri inherits Carta(nombre = "Ahri", 
  descripcion = "Lanza 3 ataques fisicos con +30% daño", 
  cooldown = 3){
 
  override method usarSobre(objetivo, usuario){
    const daño = usuario.dañoFisico() * 1.3
    objetivo.recibirDaño(daño * 3)
  }
}


//object garen inherits Carta(nombre = "Garen", descripcion = "Aniquila si el enemigo tiene 15% de vida, si no inflige 15% mas de ataque", cooldown = 2){
 
 // override method usarSobre(objetivo, usuario){
   // if (objetivo.vida )
  //}
//}


