import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Turno \(viewModel.gameEngine.turnCount)")
                    .font(.headline)
                Spacer()
                Text("Mana: \(viewModel.gameEngine.currentPlayer.mana)/\(viewModel.gameEngine.currentPlayer.maxMana)")
                    .foregroundColor(.blue)
            }
            .padding()
            
            if viewModel.gameEngine.turnCount % 2 == 1 {
                VStack {
                    Text("Tu mano")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.gameEngine.currentPlayer.hand) { card in
                                CardView(card: card)
                                    .onTapGesture {
                                        if let index = viewModel.gameEngine.currentPlayer.hand.firstIndex(where: { $0.id == card.id }) {
                                            viewModel.playCard(at: index)
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
            } else {
                Text("Turno de la IA...")
                    .italic()
                    .foregroundColor(.gray)
            }
            
            VStack {
                Text("Tu campo")
                    .font(.caption)
                HStack(spacing: 8) {
                    ForEach(viewModel.gameEngine.currentPlayer.battlefield) { card in
                        CardView(card: card)
                            .frame(width: 60, height: 80)
                    }
                }
                .padding(.horizontal)
            }
            
            VStack {
                Text("Campo enemigo")
                    .font(.caption)
                HStack(spacing: 8) {
                    ForEach(viewModel.gameEngine.opponent.battlefield) { card in
                        CardView(card: card)
                            .frame(width: 60, height: 80)
                            .opacity(0.7)
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            HStack {
                Button("Siguiente turno") {
                    viewModel.nextTurn()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Reiniciar") {
                    viewModel.resetGame()
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .padding()
    }
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        VStack(spacing: 4) {
            Text(card.name)
                .font(.caption)
                .lineLimit(1)
            Text("\(card.cost) ⚡")
                .font(.caption2)
                .foregroundColor(.orange)
            Text(card.type.rawValue)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(width: 70, height: 100)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(card.type == .creature ? Color.red.opacity(0.2) :
                      card.type == .spell ? Color.blue.opacity(0.2) :
                      Color.green.opacity(0.2))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
