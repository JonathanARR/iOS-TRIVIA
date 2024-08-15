//
//  Player.swift
//  TRIVIA
//
//  Created by Federico Mireles on 14/08/24.
//

import UIKit

class Player: NSObject {
    var name: String
    var score: Int
    var avatar = "avatar0.png"
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}
