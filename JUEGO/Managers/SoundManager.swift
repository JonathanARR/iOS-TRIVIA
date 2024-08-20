//
//  SoundManager.swift
//  TRIVIA
//
//  Created by Federico Mireles on 14/08/24.
//

import UIKit
import AVFoundation

class SoundManager: NSObject {
    static let shared = SoundManager()
    var backgroundMusicPlayer: AVAudioPlayer?
    var soundEffectPlayer: AVAudioPlayer?
    var isMuted: Bool = false
        
    private override init() {
        super.init()
    }
    
    func playBackgroundMusic(_ filename: String) {
        if let path = Bundle.main.path(forResource: filename, ofType: nil) {
            let url = URL(fileURLWithPath: path)
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundMusicPlayer?.numberOfLoops = -1
                backgroundMusicPlayer?.play()
            } catch {
                print("Error playing background music: \(error.localizedDescription)")
            }
        } else {
            print("File not found: \(filename)")
        }
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }

    func playSoundEffect(_ filename: String) {
        if let path = Bundle.main.path(forResource: filename, ofType: nil) {
            let url = URL(fileURLWithPath: path)
            do {
                soundEffectPlayer?.stop() 
                soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
                soundEffectPlayer?.play()
            } catch {
                print("Error playing sound effect: \(error.localizedDescription)")
            }
        } else {
            print("File not found: \(filename)")
        }
    }
    
    func mute() {
        isMuted = true
        backgroundMusicPlayer?.volume = 0
        soundEffectPlayer?.volume = 0
    }
    
    func unmute() {
        isMuted = false
        backgroundMusicPlayer?.volume = 1
        soundEffectPlayer?.volume = 1
    }
}
