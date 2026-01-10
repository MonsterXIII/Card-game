// Modelo de carta
// Esta estructura representa una carta dentro del juego
// Se pueden a;adir mas propiedades despues.

import Foundation

//tipo de carta (monstruo, magia, trampa)
enum CardType: String, CaseIterable {
    case creature = "Creature"
    case spell = "Spell"
    case trap = "Trap"
}

//Cada carta tiene un nombre, costo de mana, tipo y un ID unico
//'Identifiable' permite usarla facilmente en listas de SwiftUI
struct Card: Identifiable, Equatable {
    let id = UUID() //Identificador unico automatico
    let name: String //Nombre de la carta
    let cost: Int //Costo de mana que se necesita para jugar
    let type: CardType //Tipo de carta
    
    //Para simplificar, esta carta no tiene efectos especiales, aun
    //Mas adelante para fines de prueba se anadiran funciones onPlay() o onDestroy()
    
}
