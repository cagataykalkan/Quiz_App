//
//  ResultVC.swift
//  Quizz
//
//  Created by Çağatay KALKAN on 8.05.2024.
//

import UIKit
import AVFoundation
import AVKit

class ResultVC: UIViewController {

    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.titleView?.tintColor = UIColor(named: "white")
        

        print("Correct Answers: \(correctAnswers), Incorrect Answers: \(incorrectAnswers)")

        scoreLabel.text = "\(correctAnswers)/\(incorrectAnswers+correctAnswers)"
        
                
        
    }
    
    @IBAction func videoButton(_ sender: Any) {
        playVideo(videoIndex: correctAnswers)

    }
    
    
    func playVideo(videoIndex: Int){
        guard let videoPath = Bundle.main.path(forResource: String(videoIndex), ofType: "mp4") else{
            print("video dosyası bulunamadı")
            return
        }
        
        let videoURL = URL(filePath: videoPath)
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        guard let viewController = UIApplication.shared.windows.first?.rootViewController else {
            print("view controller bulunamadı")
            return
        }
        
        viewController.present(playerViewController, animated: true){
            player.play()
        }
    }
    
}
