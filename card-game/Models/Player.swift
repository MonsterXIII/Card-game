// Estado de un jugador
// Representa al jugador, la persona o la IA
// Inlcuye la mano, el campo, mana actual y maximo

import Foundation

struct Player: Equatable {
    var hand: [Card] //Arreglo de datos de las cartas en mano
    var battlefield: [Card] //Arreglo de datos con las cartas actualmente en el campo de batalla
    var mana: Int //Mana actual o maximo, de momento no se implementara el mana maximo ya que no se tiene decidido el sistema
    var maxMana : Int //Mana maximo que un jugador puede generar
    let isHuman: Bool //Para diferenciar el jugador de una IA
    
    //Inicializa un jugador vacio con 0 mana
    init(isHuman: Bool){
        self.hand = []
        self.battlefield = []
        self.mana = 0
        self.maxMana = 0
        self.isHuman = isHuman
    }
}
