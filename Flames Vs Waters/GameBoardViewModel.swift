//
//  GameBoardViewModel.swift
//  Flames Vs Waters
//
//  Created by Alpsu Dilbilir on 18.12.2021.
//

import SwiftUI

final class GameBoardViewModel: ObservableObject {
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    @State private var isPlayerFlame: Bool
    @State var isGameBoardDisabled: Bool
    
    init(isPlayerFlame: Bool, isGameBoardDisabled: Bool) {
        self.isPlayerFlame = isPlayerFlame
        self.isGameBoardDisabled = isGameBoardDisabled
    }
    
    @Published var alertItem: AlertItem?
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    
    
    func VisualizeGame(for index: Int) {
        if !isCircleEmpty(in: moves, for: index) {  return }
        moves[index] = Move(element: isPlayerFlame ? .flame : .water, boardIndex: index)
        isGameBoardDisabled = true
        if checkWinConditionForPlayer(for: isPlayerFlame ? .flame : .water, in: moves) {
            alertItem = AlertContext.playerWin
            return
        }
        if checkDrawCondition(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = VisualizeComputerMoves(in: moves)
            moves[computerPosition] = Move(element: isPlayerFlame ? .water : .flame, boardIndex: computerPosition)
            isGameBoardDisabled = false
            if checkWinConditionForComputer(for: isPlayerFlame ? .water : .flame, in: moves) {
                alertItem = AlertContext.computerWin
                return
            }
            if checkDrawCondition(in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }
    func VisualizeComputerMoves(in moves: [Move?]) -> Int {
        //If computer can win then win
        let winConditions: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let computerMoves = moves.compactMap { $0 }.filter { isPlayerFlame ? $0.element == .water : $0.element == .flame }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        for condition in winConditions {
            let winCondition = condition.subtracting(computerPositions)
            if winCondition.count == 1 {
                let isAvailable = isCircleEmpty(in: moves, for: winCondition.first!)
                if isAvailable { return winCondition.first! }
            }
        }
        //If computer can't win then block
        let playerMoves = moves.compactMap { $0 }.filter { isPlayerFlame ? $0.element == .flame : $0.element == .water}
        let playerPosition = Set(playerMoves.map { $0.boardIndex })
        for condition in winConditions {
            let winCondition = condition.subtracting(playerPosition)
            if winCondition.count == 1 {
                let isAvailable = isCircleEmpty(in: moves, for: winCondition.first! )
                if isAvailable { return winCondition.first!}
            }
        }
        //If computer can't win can't block then take the middle
        let center = 4
        if isCircleEmpty(in: moves, for: center) { return center }
        
        
        //If cant do anything make random
        isPlayerFlame.toggle()
        var computerMove = Int.random(in: 0..<9)
        while !isCircleEmpty(in: moves, for: computerMove) {
            computerMove = Int.random(in: 0..<9)
        }
        isPlayerFlame.toggle()
        return computerMove
    }
    func checkWinConditionForPlayer(for element: Element, in moves: [Move?]) -> Bool {
        let winConditions: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let playerMoves = moves.compactMap { $0 }.filter { isPlayerFlame ? $0.element == .flame : $0.element == .water }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        for condition in winConditions where condition.isSubset(of: playerPositions)
        { return true }
        return false
    }
    
    func checkWinConditionForComputer(for element: Element, in moves: [Move?]) -> Bool {
        let winConditions: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let computerMoves = moves.compactMap { $0 }.filter { isPlayerFlame ? $0.element == .water : $0.element == .flame }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        for condition in winConditions where condition.isSubset(of: computerPositions)
        { return true }
        return false
    }
    
    func isCircleEmpty(in moves: [Move?], for index: Int) -> Bool {
        return moves[index] == nil ? true : false
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
    
    func checkDrawCondition(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
}
