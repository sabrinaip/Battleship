//
//  gameEngine.swift
//  Battleship
//
//  Created by Sabrina Ip on 9/18/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class gameEngine {
    
    enum Name {
        case carrier
        case battleship
        case cruiser
        case submarine
        case destroyer
    }
    
    let boardSize: Int
    
    init(boardSize: Int) {
        self.boardSize = boardSize
        buildShips()
    }

    var ships: [Name:[Int]] = [
        .carrier: Array(repeating: 0, count:5),
        .battleship: Array(repeating: 0, count:4),
        .cruiser: Array(repeating: 0, count:3),
        .submarine: Array(repeating: 0, count:3),
        .destroyer: Array(repeating: 0, count:2)
    ]
    
    var shipSpot = [Int]()
    
    var hits = 0
    
    func buildShips() {
        var occupied = Array(repeating:false, count: boardSize*boardSize + 1)
        occupied[0] = true // spot 0 should not exist, cannot build a ship here
        
        for var ship in ships {
            var startingPoint = 0
            var canBuild = false
            
            while !canBuild {
                startingPoint = Int(arc4random_uniform(UInt32(boardSize*boardSize + 1)))
                canBuild = true
                for spot in 0..<ship.value.count {
                    if startingPoint + ship.value.count > boardSize*boardSize + 1 {
                        canBuild = false // passes 100, goes off the board
                    } else if startingPoint % 10 == 0 {
                        canBuild = false
                    } else if ship.value.count + (startingPoint % 10) > 11 {
                        canBuild = false // assures that it's on the same row
                    } else if occupied[spot+startingPoint] {
                        canBuild = false // occupied by another ship
                    }
                }
            }
            
            for spot in 0..<ship.value.count {
                occupied[spot+startingPoint] = true
                ship.value[spot] = spot+startingPoint
            }
            ships[ship.key] = ship.value
        }
        for (index, shipExists) in occupied.enumerated() where index > 0 && shipExists {
            shipSpot.append(index)
        }
        //return shipSpot
    }
    
    func hitShipCheck(tag: Int) -> Bool {
        for spot in shipSpot where spot == tag {
            return true
        }
        return false
    }

}
