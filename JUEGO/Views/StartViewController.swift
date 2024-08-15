import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var pgvProgress: UIProgressView!
    
    var player: Player!
    var countdownTimer = Timer()
    var progressTimer = Timer()
    var seconds = 3
    let totalSeconds: Float = 3.0
    var elapsedTime: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTimer.text = "\(seconds)"
        pgvProgress.progress = 0.0
        startTimers()
    }
    
    func startTimers() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        progressTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgGame" {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.player = self.player
        }
    }

    
    @objc func countdown() {
        seconds -= 1
        if seconds <= 0 {
            countdownTimer.invalidate()
            // Esperar a que la barra de progreso se complete antes de realizar la transición
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.performSegue(withIdentifier: "sgGame", sender: self)
            }
        } else {
            lblTimer.text = "\(seconds)"
        }
    }
    
    @objc func updateProgress() {
        elapsedTime += 0.01
        let progress = min(elapsedTime / totalSeconds, 1.0)
        pgvProgress.progress = progress
        
        if progress >= 1.0 {
            progressTimer.invalidate()
        }
    }
}
