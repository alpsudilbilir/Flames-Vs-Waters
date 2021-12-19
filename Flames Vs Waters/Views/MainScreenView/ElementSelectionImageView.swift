//
//  ElementSelectionImageView.swift
//  Flames Vs Waters
//
//  Created by Alpsu Dilbilir on 20.12.2021.
//

import SwiftUI

struct ElementSelectionImageView: View {
    var symbolName: String
    var colors: [Color]
    var proxy: GeometryProxy
    var body: some View {
        Image(systemName: symbolName)
            .renderingMode(.original)
            .resizable()
            .frame(width: proxy.size.width / 4, height: proxy.size.width / 4, alignment: .center)
            .gradientForeground(colors: colors)
    }
}
