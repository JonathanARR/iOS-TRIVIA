//
//  SplashWindowViewController.swift
//  TRIVIA
//
//  Created by Federico Mireles on 14/08/24.
//

import UIKit

class SplashWindowViewController: UIViewController {

    @IBOutlet weak var imvSplash: UIImageView!
    @IBOutlet weak var pgvCarga: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Inicio del splash
        imvSplash.alpha = 0.0
        imvSplash.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        pgvCarga.progress = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Animación
        UIView.animate(withDuration: 1.75, animations: {
            self.imvSplash.alpha = 1.0
            self.imvSplash.transform = CGAffineTransform.identity
        }) { _ in
            // Iniciar la animación de la barra de progreso
            self.animateProgress()
        }
    }
    
    func animateProgress() {
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            self.pgvCarga.progress += 0.02
            if self.pgvCarga.progress >= 1.0 {
                timer.invalidate()
                self.performSegue(withIdentifier: "sgSplash", sender: self)
            }
        }
    }
}
