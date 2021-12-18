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
                    LinearGradient(colors: [.black], startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                    VStack(spacing: 5) {
                        HStack {
                            Text("Flames")
                                .font(.custom("PermanentMarker-Regular", size: 70))
                                .gradientForeground(colors: [.red, .orange])
                            
                            Image(systemName: "flame.fill")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .gradientForeground(colors: [.red, .orange])
                        }
                        Text("Vs")
                            .font(.custom("PermanentMarker-Regular", size: 70))
                            .gradientForeground(colors: [.gray, .white])
                        HStack {
                            Image(systemName: "drop.fill")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .gradientForeground(colors: [.white, .blue])
                            Text("Waters")
                                .font(.custom("PermanentMarker-Regular", size: 70))
                                .gradientForeground(colors: [.white, .blue])
                        }
                        Spacer()
                        Text("Choose Your Side")
                            .font(.custom("PermanentMarker-Regular", size: 40))
                            .gradientForeground(colors: [.red, .orange, .blue, .white])
                        Spacer()
                        HStack(spacing: 50) {


                            NavigationLink {
                               GameBoardView(viewModel: GameBoardViewModel(isPlayerFlame: true, isGameBoardDisabled: false))
                            } label: {
                                Image(systemName: "flame.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .gradientForeground(colors: [.red, .orange])
                            }
                            NavigationLink {
                                GameBoardView(viewModel: GameBoardViewModel(isPlayerFlame: false, isGameBoardDisabled: false))
                            } label: {
                                Image(systemName: "drop.fill")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .gradientForeground(colors: [.white, .blue])
                            }
                        }
                        Spacer()
                        
                    }
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
