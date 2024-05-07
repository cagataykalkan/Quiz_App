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
    

    @IBOutlet weak var parolaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func kayıtOlButton(_ sender: Any) {

        guard let email = emailTextField.text else {return}
        guard let parola = parolaTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: parola) { firebaseResault, error in
            if let e = error{
                
                let errorMessage = e.localizedDescription
                
                print(errorMessage)
                
                if errorMessage == "The email address is already in use by another account."{
                    let alertController = UIAlertController(title: "Bu mail adresine kayıtlı hesap vardır", message: "Başka bir mail adresi ile deneyiniz veya giriş yapınız.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Tekrar Deneyiniz", style: .cancel)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                }
                
                if errorMessage == "The password must be 6 characters long or more."{
                    let alertController = UIAlertController(title: "Yetersiz parola", message: "Parolanız minimum 6 karakter içermeli.", preferredStyle: .alert)
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
