//
//  LoginVC.swift
//  Quizz
//
//  Created by Çağatay KALKAN on 4.05.2024.
//

import UIKit
import Firebase


class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var parolaTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "FontColor")]
        navigationController?.navigationBar.tintColor = UIColor(named: "FontColor")

    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        guard let email = emailTextField.text else {return}
        guard let parola = parolaTextField.text else {return}
         
        Auth.auth().signIn(withEmail: email, password: parola) { firebaseResault, error in
            if let e = error{
                let errorMessage = e.localizedDescription
                print(errorMessage)
                
                if errorMessage == "The supplied auth credential is malformed or has expired."{
                    let alertController = UIAlertController(title: "Hatalı giriş", message: "Bilgilerinizi kontrol edip yeniden giriniz.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Tekrar Deneyiniz", style: .cancel)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                }
                
                if errorMessage == "The email address is badly formatted."{
                    let alertController = UIAlertController(title: "Hatalı email adresi", message: "Geçerli bir mail adresi giriniz.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Tekrar Deneyiniz", style: .cancel)
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
