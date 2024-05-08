//
//  ViewController.swift
//  Quizz
//
//  Created by Çağatay KALKAN on 3.05.2024.
//

import UIKit

class MainPageVC: UIViewController {

    
    @IBOutlet weak var QuizzTitleLabel: UILabel!
    @IBOutlet weak var WelcomeToLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.titleView?.tintColor = UIColor(named: "white")
        
        QuizzTitleLabel.font = UIFont(name: "SedanSC-Regular", size: 80)

        WelcomeToLabel.font = UIFont(name: "SedanSC-Regular", size: 37)
        
        
    }


}

