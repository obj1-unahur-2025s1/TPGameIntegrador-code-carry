import cartas.*
import personaje.*
import sonido.*

// PORO

const poro = new PersonajePrincipal()

//ENEMIGOS
const vacuolarva = new PersonajeEnemigo (
  vidaInicial = 250, 
  ataque = 30, 
  defensa = 15, 
  nombre = "Vacuolarva",
  sonidoAtaque = sonidoAtaqueLarva,
  sonidoAparicion = sonidoAparicionLarva,
  imagen = "larva-normal.png",
  posicion = game.at(15,2)
)

const heraldo = new PersonajeEnemigo (
  vidaInicial = 400,
  ataque = 45,
  defensa = 30,
  nombre = "Heraldo",
  sonidoAtaque = sonidoAtaqueLarva,
  sonidoAparicion = sonidoAparicionHeraldo,
  imagen = "heraldoNuevo-normal.png",
  posicion = game.at(13,2)
)

const baron = new PersonajeEnemigo (
  vidaInicial = 500,
  ataque = 60,
  defensa = 40,
  nombre = "Baron",
  sonidoAtaque = sonidoAtaqueLarva,
  sonidoAparicion = sonidoAparicionBaron,
  imagen = "Baron-normal.png",
  posicion = game.at(13,2)
)

// CARTAS
const garen = new CartaAD(nombre = "Garen", cooldownInicial = 5, ataque = 70, imagen = "garenfinal.png")

const ahri = new CartaAP(nombre = "Ahri", cooldownInicial = 5, poderMagico = 80, imagen = "ahrifinal.png")

const soraka = new CartaSUPP(nombre = "Soraka", cooldownInicial = 10, poderMagico = 40, imagen = "sorakafinal.png")

const draven = new CartaAD(nombre = "Draven", cooldownInicial = 8, ataque = 70, imagen = "dravenfinal.png")

const aatrox = new CartaAD(nombre = "Aatrox", cooldownInicial = 3, ataque = 65, imagen = "aatroxfinal.png")

const alistar = new CartaAP(nombre = "Alistar", cooldownInicial = 5, poderMagico = 70, imagen = "alistarfinal.png")

const amumu = new CartaAP(nombre = "Amumu", cooldownInicial = 4, poderMagico = 75, imagen = "amumufinal.png")

const aurelion = new CartaAP(nombre = "Aurelion", cooldownInicial = 5, poderMagico = 80, imagen = "aurelionfinal.png")

const blitz = new CartaAP(nombre = "Blitzcranck", cooldownInicial = 5, poderMagico = 65, imagen = "blitzfinal.png")

const brand = new CartaAP(nombre = "Brand", cooldownInicial = 5, poderMagico = 85, imagen = "brandfinal.png")

const camille = new CartaAD(nombre = "Camille", cooldownInicial = 6, ataque = 65, imagen = "camilleFinal.png")

const fiora = new CartaAD(nombre = "Fiora", cooldownInicial = 7, ataque = 75, imagen = "fiorafinal.png")

const ashe = new CartaAD(nombre = "Ashe", cooldownInicial = 4, ataque = 70, imagen = "ashefinal.png")

const jhin = new CartaAD(nombre = "Jhin", cooldownInicial = 4, ataque = 74, imagen = "jhinfinal.png")

const karma = new CartaAP(nombre = "Karma", cooldownInicial = 6, poderMagico = 80, imagen = "karmafinal.png")

const morgana = new CartaAP(nombre = "Morgana", cooldownInicial = 5, poderMagico = 56, imagen = "morganafinal.png")

const nasus = new CartaAD(nombre = "Nasus", cooldownInicial = 3, ataque = 70, imagen = "nasusfinal.png")

const pyke = new CartaAD(nombre = "Pyke", cooldownInicial = 4, ataque = 75, imagen = "pykefinal.png")

