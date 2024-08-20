import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var viewQuestion: UIView!
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
        
        viewQuestion.makeRoundView(cornerRadius: 2.5)
        game = Game(questions: QuestionLoader.loadQuestions())
        startNewGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SoundManager.shared.playBackgroundMusic("second-hand-149907.mp3")
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
        
        resetButtonColors()
        
        updateUI()
    }
    
    @IBAction func answerSelected(_ sender: UIButton) {
        guard let answer = sender.title(for: .normal) else { return }
        let correct = game.checkAnswer(answer)
        
        let soundName = correct ? "correct-156911.mp3" : "wrong-answer-129254.mp3"
        SoundManager.shared.playSoundEffect(soundName)
        
        animateButton(sender, correct: correct)
        
        if game.isGameOver() {
            endGame()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                self?.loadNextQuestion()
            }
        }
    }
    
    func animateButton(_ button: UIButton, correct: Bool) {
        UIView.animate(withDuration: 0.1) {
            button.backgroundColor = correct ? .green : .red
            button.setTitleColor(.white, for: .normal)
        }
    }
    
    func resetButtonColors() {
        let buttons = [btnA1, btnA2, btnA3, btnA4]
        for button in buttons {
            button?.backgroundColor = .systemBackground
            button?.setTitleColor(.black, for: .normal)
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
            SoundManager.shared.playSoundEffect("clock-alarm-8761.mp3")
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
        player.score = game.getScore()
        SoundManager.shared.stopBackgroundMusic()
        
        print("Player Name: \(player.name), Score: \(player.score)")
        
        let alert = UIAlertController(title: "Game Over", message: "Your score: \(game.getScore())", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            RecordsManager.shared.addRecord(self.player)
            
            // print("Records after adding: \(RecordsManager.shared.getTopRecords())")
            
            SoundManager.shared.playBackgroundMusic("WiiSports-BoxingResultsMusic.mp3")
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
