//
//  Question.swift
//  TRIVIA
//
//  Created by Federico Mireles on 14/08/24.
//

import UIKit

class Question: NSObject {
    var questionText: String
    var options: [String]
    var answer: String
    
    init(questionText: String, options: [String], answer: String) {
        self.questionText = questionText
        self.options = options
        self.answer = answer
    }
}
