//
//  BoardCircleView.swift
//  Flames Vs Waters
//
//  Created by Alpsu Dilbilir on 19.12.2021.
//

import SwiftUI

struct BoardCircleView: View {
    var proxy: GeometryProxy
    var body: some View {
        Circle()
            .frame(width: proxy.size.width / 3 - 10, height: proxy.size.width / 3 - 10)
            .gradientForeground(colors: [.black, .white])
    }
}
