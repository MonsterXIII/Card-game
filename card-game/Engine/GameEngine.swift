// Motor del juego
// Aqui vive la logica real, turnos, relgas, IA.
// No depende de SwiftUI ni de la interfaz, facil de probar y escalar

import Foundation

class GameEngine {
    //Estado actual del juego
    var currentPlayer: Player
    var opponent: Player
    var turnCount: Int = 0
    var gameOver: Bool = false
    
    //Biblioteca (mazo) para el jugador humano (solo para test)
    private var humanDeck: [Card] = [
        Card( name: "Aragorn", cost: 2, type: CardType.creature),
        Card( name: "Crysalis", cost: 1, type: CardType.creature),
        Card(name: "Bridge Trap", cost: 2, type: .trap),
        Card(name: "Sword of Destiny", cost: 3, type: .spell),
        Card(name: "Onorama's Blessing", cost: 4, type: .spell)
    ]
    
    private var iaDeck: [Card] = [
        Card(name: "Esqueleto", cost: 1, type: .creature),
        Card(name: "Rayo", cost: 2, type: .spell),
        Card(name: "Niebla", cost: 1, type: .trap),
        Card(name: "Coloso de Piedra", cost: 5, type: .creature),
        Card(name: "Paralisis", cost: 3, type: .spell)
    ]
    
    //Inicializa el juego con dos jugadores
    init(){
        self.currentPlayer = Player(isHuman: true)
        self.opponent = Player(isHuman: false)
        startnewGame()
    }
    
    //Funcion para comenzar un juego nuevo, reparte cartas iniciiales y empieza el primer turno
    func startnewGame(){
        //Roba 5 cartas iniciales (sin reemplazo)
        currentPlayer.hand = Array(humanDeck.prefix(5))
        opponent.hand = Array(iaDeck.prefix(5))
        nextTurn()
    }
    
    func nextTurn(){
        turnCount += 1
        
        let isHumanTurn = turnCount % 2 == 1
        
        //El jugador activo recibe 1 de mana, 10 como maximo
        if isHumanTurn {
            currentPlayer.maxMana = min(currentPlayer.maxMana + 1,10)
            currentPlayer.mana = currentPlayer.maxMana
            
            //Logica para robar la carta TODO
            
        }
        else {
            opponent.maxMana = min(currentPlayer.maxMana + 1, 10)
            opponent.mana = opponent.maxMana
            
            //Funcion para que la IA juegue el turno
            aiPlayTurn()
            
        }
    }
    
    private func aiPlayTurn() {
        guard !gameOver else {return}
        
        //Busca la primera carta jugable
        if let index = opponent.hand.firstIndex(where: {$0.cost <= opponent.mana}){
            let card = opponent.hand.remove(at: index)
            opponent.mana -= card.cost
            opponent.battlefield.append(card)
        }
        
        //Despues del turno de la IA, pasa al jugador
        //Simulando turnos alternos
        //Esto es solo para la simulacion, esto lo controlara el sistema de turnos en el futuro
            
        
    }
    
    func playCard(fromHandAt index: Int){
        guard !gameOver, currentPlayer.hand.indices.contains(index) else {return}
        let card = currentPlayer.hand[index]
        
        if currentPlayer.mana >= card.cost {
            currentPlayer.hand.remove(at: index)
            currentPlayer.mana -= card.cost
            currentPlayer.battlefield.append(card)
        }
    }
    
    func resetGame(){
        turnCount = 0
        gameOver = false
        currentPlayer = Player(isHuman: true)
        opponent = Player(isHuman: false)
        startnewGame()
    }
}
