//
//  Player.swift
//  TRIVIA
//
//  Created by Federico Mireles on 14/08/24.
//

import UIKit

class Player: NSObject, Codable {
    var name: String
    var score: Int
    var avatar: String
    
    init(name: String, score: Int, avatar: String = "avatar0.png") {
        self.name = name
        self.score = score
        self.avatar = avatar
    }
    
    override var description: String {
        return "Name: \(name), Score: \(score), Avatar: \(avatar)"
    }
}
