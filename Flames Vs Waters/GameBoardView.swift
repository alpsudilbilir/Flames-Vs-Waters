//
//  GameBoardView.swift
//  Flames Vs Waters
//
//  Created by Alpsu Dilbilir on 18.12.2021.
//

import SwiftUI

struct GameBoardView: View {
    
    @StateObject var viewModel = GameBoardViewModel(isPlayerFlame: true, isGameBoardDisabled: false)
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    LazyVGrid(columns: viewModel.columns) {
                        
                        ForEach(0..<9) { i in
                            ZStack {
                                Circle()
                                    .frame(width: geometry.size.width / 3 - 10, height: geometry.size.width / 3 - 10)
                                    .gradientForeground(colors: [.black, .white])
                                if viewModel.moves[i]?.element == .flame {
                                    FireImage(proxy: geometry, index: i, moves: viewModel.moves)
                                } else {
                                    WaterImage(proxy: geometry, index: i, moves: viewModel.moves)
                                }
                            }
                            .padding(.vertical, 4)
                            .onTapGesture {
                                viewModel.VisualizeGame(for: i)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .disabled(viewModel.isGameBoardDisabled)
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {
                    viewModel.resetGame()
                }))
            })
            .offset(y: -20)
        }
    }
}

enum Element {
    case flame
    case water
}

struct Move {
    let element: Element
    let boardIndex: Int
    var elementIndicator: String {
        return element == .flame ? "flame.fill" : "drop.fill"
    }
}


struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView()
    }
}

struct FireImage: View {
    var proxy: GeometryProxy
    var index: Int
    var moves: [Move?]
    var body: some View {
        Image(systemName: moves[index]?.elementIndicator ?? "")
            .renderingMode(.original)
            .resizable()
            .frame(width: proxy.size.width / 5, height: proxy.size.width / 5)
            .gradientForeground(colors: [.red, .orange])
    }
}
struct WaterImage: View {
    var proxy: GeometryProxy
    var index: Int
    var moves: [Move?]
    var body: some View {
        Image(systemName: moves[index]?.elementIndicator ?? "")
            .renderingMode(.original)
            .resizable()
            .frame(width: proxy.size.width / 5, height: proxy.size.width / 5)
            .gradientForeground(colors: [.blue, .white])
    }
}
