// ViewModel, es el puente entre el motor y la vista
// SwiftUI observara los cambios aqui, y actualizara la IU automaticamente

import Foundation
import Combine //Lo necesitamos para published, puedes revisar en documentacion

class GameViewModel: ObservableObject {
    @Published var gameEngine: GameEngine
    
    init() {
        self.gameEngine = GameEngine()
    }
    
    //Acciones que la vista puede llamar
    func playCard(at index: Int) {
        gameEngine.playCard(fromHandAt: index)
    }
    
    func nextTurn(){
        gameEngine.nextTurn()
    }
    
    func resetGame(){
        gameEngine.resetGame()
    }
    
    
}
