import cartas.*
import personaje.*
import sonido.*

// PORO

const poro = new PersonajePrincipal(nombre = "Poro")

//ENEMIGOS
const vacuolarva = new PersonajeEnemigo (
  vidaInicial = 250, //250
  ataque = 30, 
  defensa = 15, 
  nombre = "Vacuolarva",
  sonidoAtaque = sonidoAtaqueLarva,
  sonidoAparicion = sonidoAparicionLarva,
  posicion = game.at(15,2)
)

const heraldo = new PersonajeEnemigo (
  vidaInicial = 400, //400
  ataque = 45,
  defensa = 30,
  nombre = "Heraldo",
  sonidoAtaque = sonidoAtaqueLarva,
  sonidoAparicion = sonidoAparicionHeraldo,
  posicion = game.at(13,2)
)

const baron = new PersonajeEnemigo (
  vidaInicial = 500, //500
  ataque = 60,
  defensa = 40,
  nombre = "Baron",
  sonidoAtaque = sonidoAtaqueLarva,
  sonidoAparicion = sonidoAparicionBaron,
  posicion = game.at(13,2)
)

// CARTAS
const garen = new CartaAD(nombre = "Garen", cooldownInicial = 5, ataque = 70)

const ahri = new CartaAP(nombre = "Ahri", cooldownInicial = 5, poderMagico = 80)

const soraka = new CartaSUPP(nombre = "Soraka", cooldownInicial = 10, poderMagico = 40)

const draven = new CartaAD(nombre = "Draven", cooldownInicial = 8, ataque = 70)

const aatrox = new CartaAD(nombre = "Aatrox", cooldownInicial = 3, ataque = 65)

const alistar = new CartaAP(nombre = "Alistar", cooldownInicial = 5, poderMagico = 70)

const amumu = new CartaAP(nombre = "Amumu", cooldownInicial = 4, poderMagico = 75)

const aurelion = new CartaAP(nombre = "Aurelion", cooldownInicial = 5, poderMagico = 80)

const blitz = new CartaAP(nombre = "Blitz", cooldownInicial = 5, poderMagico = 65)

const brand = new CartaAP(nombre = "Brand", cooldownInicial = 5, poderMagico = 85)

const camille = new CartaAD(nombre = "Camille", cooldownInicial = 6, ataque = 65)

const fiora = new CartaAD(nombre = "Fiora", cooldownInicial = 7, ataque = 75)

const ashe = new CartaAD(nombre = "Ashe", cooldownInicial = 4, ataque = 70)

const jhin = new CartaAD(nombre = "Jhin", cooldownInicial = 4, ataque = 74)

const karma = new CartaAP(nombre = "Karma", cooldownInicial = 6, poderMagico = 80)

const morgana = new CartaAP(nombre = "Morgana", cooldownInicial = 5, poderMagico = 56)

const nasus = new CartaAD(nombre = "Nasus", cooldownInicial = 3, ataque = 70)

const pyke = new CartaAD(nombre = "Pyke", cooldownInicial = 4, ataque = 75)

