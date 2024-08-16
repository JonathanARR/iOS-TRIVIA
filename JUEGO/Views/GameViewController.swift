import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var lblQuestionIndex: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblLives: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnA1: UIButton!
    @IBOutlet weak var btnA2: UIButton!
    @IBOutlet weak var btnA3: UIButton!
    @IBOutlet weak var btnA4: UIButton!
    @IBOutlet weak var imvAlarm: UIImageView!
    @IBOutlet weak var pgvQuestionIndex: UIProgressView!
    
    var player: Player!
    var game: Game!
    var countdownTimer: Timer?
    var remainingTime: Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(questions: QuestionLoader.loadQuestions())
        startNewGame()
    }

    func startNewGame() {
        game.resetGame()
        loadNextQuestion()
        startTimer()
        updateUI()
    }
    
    func loadNextQuestion() {
        guard let question = game.nextQuestion() else {
            endGame()
            return
        }
        
        lblQuestion.text = question.questionText
        btnA1.setTitle(question.options[0], for: .normal)
        btnA2.setTitle(question.options[1], for: .normal)
        btnA3.setTitle(question.options[2], for: .normal)
        btnA4.setTitle(question.options[3], for: .normal)
        
        // Actualizar UI después de cargar una nueva pregunta
        updateUI()
    }
    
    @IBAction func answerSelected(_ sender: UIButton) {
        guard let answer = sender.title(for: .normal) else {return}
        let correct = game.checkAnswer(answer)
        
        if game.isGameOver() {
            endGame()
        } else {
            loadNextQuestion()
        }
    }
    
    func updateUI() {
        lblQuestionIndex.text = String(format: "%02d/%02d", game.currentQuestionIndex, game.questions.count)
        lblLives.text = String(game.getLives())
        pgvQuestionIndex.progress = Float(game.currentQuestionIndex + 1) / Float(game.questions.count)
    }
    
    func startTimer() {
        remainingTime = 60
        updateTimerLabel()
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            self?.updateTimer()
        }
    }
    
    func updateTimer() {
        remainingTime -= 1
        updateTimerLabel()
        
        if remainingTime <= 0 {
            countdownTimer?.invalidate()
            endGame()
        }
    }
    
    func updateTimerLabel() {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        lblTimer.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func endGame() {
        countdownTimer?.invalidate()
        print(player.name)
        
        let alert = UIAlertController(title: "Game Over", message: "Your score: \(game.getScore())", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
