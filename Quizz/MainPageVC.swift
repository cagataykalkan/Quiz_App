//
//  ViewController.swift
//  Quizz
//
//  Created by Çağatay KALKAN on 3.05.2024.
//

import UIKit

class MainPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.titleView?.tintColor = UIColor(named: "white")

        
    }


}

