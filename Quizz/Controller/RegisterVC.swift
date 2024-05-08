//
//  RegisterVC.swift
//  Quizz
//
//  Created by Çağatay KALKAN on 4.05.2024.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var QuizzTitleLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "FontColor")]
        navigationController?.navigationBar.tintColor = UIColor(named: "FontColor")
        QuizzTitleLabel.font = UIFont(name: "SedanSC-Regular", size: 70)
    }
    
    @IBAction func registerButton(_ sender: Any) {

        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResault, error in
            if let e = error{
                
                let errorMessage = e.localizedDescription
                
                print(errorMessage)
                
                if errorMessage == "The email address is already in use by another account."{
                    let alertController = UIAlertController(title: "There is an account registered to this email address", message: "Try or log in with a different email address.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Try again", style: .cancel)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                }
                
                if errorMessage == "The password must be 6 characters long or more."{
                    let alertController = UIAlertController(title: "Insufficient password", message: "Your password must contain at least 6 characters.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Try again", style: .cancel)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                }
                
                if errorMessage == "The email address is badly formatted."{
                    let alertController = UIAlertController(title: "Incorrect email address", message: "Please enter a valid e-mail address.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Try again", style: .cancel)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                }
                
            }else{
                // goes our question screen
                self.performSegue(withIdentifier: "goToNext", sender: self )
            }
        }
        
    }
    
    

}
