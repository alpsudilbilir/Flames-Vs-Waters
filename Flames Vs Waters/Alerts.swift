//
//  Alerts.swift
//  Flames Vs Waters
//
//  Created by Alpsu Dilbilir on 18.12.2021.
//
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let buttonTitle: Text
}
struct AlertContext {
    static let draw = AlertItem(title: Text("DRAW"),
                                message: Text("Not bad"),
                                buttonTitle: Text("Play again"))
    
    static let playerWin = AlertItem(title: Text("You Won!"),
                                     message: Text("Congrats!"),
                                     buttonTitle: Text("Play again"))
    
    static let computerWin = AlertItem(title: Text("You Lost!"),
                                       message: Text("Never Give Up!"),
                                       buttonTitle: Text("Play again"))
}
