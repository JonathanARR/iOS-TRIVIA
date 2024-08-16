class Game {
    var questions: [Question]
    var currentQuestionIndex: Int = 0
    var score: Int = 0
    var lives: Int = 3
    
    init(questions: [Question]) {
        // Aleatorizar las preguntas
        self.questions = questions.shuffled()
    }

    
    func nextQuestion() -> Question? {
        if currentQuestionIndex < questions.count {
            let question = questions[currentQuestionIndex]
            currentQuestionIndex += 1
            return question
        }
        return nil
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        guard currentQuestionIndex > 0 else { return false }
        let correct = questions[currentQuestionIndex - 1].answer == answer
        if correct {
            score += 10
        } else {
            lives -= 1
        }
        print(score)
        return correct
    }
    
    func isGameOver() -> Bool {
        return lives <= 0 || currentQuestionIndex >= questions.count
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getLives() -> Int {
        return lives
    }
    
    func resetGame() {
        currentQuestionIndex = 0
        score = 0
        lives = 3
        questions.shuffle()
    }
}
