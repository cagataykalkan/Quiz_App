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

    var model: ResultModel!

    var correctAnswers: Int = 0
    var incorrectAnswers: Int = 0
    
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var checkVideoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.titleView?.tintColor = UIColor(named: "white")
        

        print("Correct Answers: \(correctAnswers), Incorrect Answers: \(incorrectAnswers)")

        scoreLabel.text = "\(correctAnswers)/\(incorrectAnswers+correctAnswers)"
        
                

        checkVideoLabel.font = UIFont(name: "BarlowSemiCondensed-Medium", size: 20)
        yourScoreLabel.font = UIFont(name: "BarlowSemiCondensed-Black", size: 50)
        scoreLabel.font = UIFont(name: "BarlowSemiCondensed-Black", size: 70)
        
    }
    
    @IBAction func videoButton(_ sender: Any) {
        playVideo(videoIndex: correctAnswers)

    }
    
    
    func playVideo(videoIndex: Int){
        guard let videoPath = Bundle.main.path(forResource: String(videoIndex), ofType: "mp4") else{
            print("video file not found")
            return
        }
        
        let videoURL = URL(filePath: videoPath)
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        guard let viewController = UIApplication.shared.windows.first?.rootViewController else {
            print("view controller not found")
            return
        }
        
        viewController.present(playerViewController, animated: true){
            player.play()
        }
    }
    
}
