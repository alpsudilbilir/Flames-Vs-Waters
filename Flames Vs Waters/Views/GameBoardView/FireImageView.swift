//
//  FireImageView.swift
//  Flames Vs Waters
//
//  Created by Alpsu Dilbilir on 19.12.2021.
//

import SwiftUI

struct FireImageView: View {
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


