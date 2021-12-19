//
//  ElementsTextView.swift
//  Flames Vs Waters
//
//  Created by Alpsu Dilbilir on 20.12.2021.
//

import SwiftUI

struct ElementsTextsView: View {
    var text: String
    var symbolName: String
    var colors: [Color]
    var proxy: GeometryProxy
    var body: some View {
        HStack {
            Text(text)
                .font(.custom("PermanentMarker-Regular", size: proxy.size.width / 6))
                .gradientForeground(colors: colors)
            
            Image(systemName: symbolName)
                .renderingMode(.original)
                .resizable()
                .frame(width: proxy.size.width / 4 - 10, height: proxy.size.width / 4 - 10, alignment: .center)
                .gradientForeground(colors: colors)
        }
    }
}
