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
            Color.black
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(0..<9) { i in
                            ZStack {
                                BoardCircleView(proxy: geometry)
                                if viewModel.moves[i]?.element == .flame {
                                    FireImageView(proxy: geometry, index: i, moves: viewModel.moves)
                                } else {
                                    WaterImageView(proxy: geometry, index: i, moves: viewModel.moves)
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
            .padding(5)
            .disabled(viewModel.isGameBoardDisabled)
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {
                    viewModel.resetGame()
                }))
            })
            .offset(y: -10)
        }
    }
}
struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView()
    }
}


