//
//  Model.swift
//  Flames Vs Waters
//
//  Created by Alpsu Dilbilir on 19.12.2021.
//

import SwiftUI

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
