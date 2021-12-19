//
//  ContentView.swift
//  Flames Vs Waters
//
//  Created by Alpsu Dilbilir on 18.12.2021.
//

import SwiftUI

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}
struct MainScreenView: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    VStack(spacing: 10) {
                        ElementsTextsView(text: "Flames", symbolName: "flame.fill", colors: [.red, .orange], proxy: geometry)
                        Text("Vs")
                            .font(.custom("PermanentMarker-Regular", size: geometry.size.width / 5))
                            .gradientForeground(colors: [.gray, .white])
                        ElementsTextsView(text: "Waters", symbolName: "drop.fill", colors: [.white, .blue], proxy: geometry)
                        Spacer()
                        Text("Choose Your Side")
                            .font(.custom("PermanentMarker-Regular", size: geometry.size.width / 10))
                            .gradientForeground(colors: [.red, .orange, .blue, .white])
                        Spacer()
                        Spacer()
                        HStack(spacing: 50) {
                            NavigationLink {
                               GameBoardView(viewModel: GameBoardViewModel(isPlayerFlame: true, isGameBoardDisabled: false))
                            } label: {
                                ElementSelectionImageView(symbolName: "flame.fill", colors: [.red, .orange], proxy: geometry)
                            }
                            NavigationLink {
                                GameBoardView(viewModel: GameBoardViewModel(isPlayerFlame: false, isGameBoardDisabled: false))
                            } label: {
                                ElementSelectionImageView(symbolName: "drop.fill", colors: [.white, .blue], proxy: geometry)
                            }
                        }
                        Spacer()
                    }
                    .offset(y: -50)
                    .padding()
                }
            }
        }
    }
}
struct MainScreenPreviews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}




