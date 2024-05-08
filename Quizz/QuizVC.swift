//
//  QuizVC.swift
//  Quizz
//
//  Created by Çağatay KALKAN on 4.05.2024.
//

import UIKit
import UserNotifications

class QuizVC: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    var questions: [[String:Any]] = []
    var currentQuestionIndex = 0
    
    var correctAnswers = 0
    var incorrectAnswers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.titleView?.tintColor = UIColor(named: "white")
        
        let urlString =  "https://opentdb.com/api.php?amount=10&token=77f7908d9675e4b332dcdbaa38d4d827a4690806dfb2b4cbed460202dc2a7914"
    
        if let url = URL(string: urlString){
            let session = URLSession.shared
            let task = session.dataTask(with: url){(data, response, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else{
                    print("veri yok")
                    return
                }
                do{
                    if let json = try JSONSerialization.jsonObject(with: data ,options: []) as? [String: Any],
                       let results = json["results"] as? [[String:Any]]{
                        self.questions = results
                        DispatchQueue.main.async {
                            self.showQuestion()
                        }
                    }else{
                        print("geçersiz json")
                    }
                }catch{
                    print("son: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
        
        
        
    }
    
    func showQuestion(){
        if currentQuestionIndex < questions.count {
            let currentQuestion = questions[currentQuestionIndex]
            if let questionText = currentQuestion["question"] as? String {
                questionLabel.text = questionText
            }
            
            var options = [String]()
            if let correctAnswer = currentQuestion["correct_answer"] as? String {
                options.append(correctAnswer)
            }
            if let incorrectAnswers = currentQuestion["incorrect_answers"] as? [String] {
                options += incorrectAnswers
            }
            options.shuffle() // Rastgele sırala
            
            if options.count >= 4 {
                button1.setTitle(options[0], for: .normal)
                button2.setTitle(options[1], for: .normal)
                button3.setTitle(options[2], for: .normal)
                button4.setTitle(options[3], for: .normal)
            }
        } else {
            print("Sorular bitti")
            self.performSegue(withIdentifier: "sonucEkraniGecis", sender: (correctAnswers,incorrectAnswers))
            print("doğru: \(correctAnswers)")
            print("yanlış: \(incorrectAnswers)")
        }
    }
 

    @IBAction func button1(_ sender: UIButton) {
        checkAnswer(selectedAnswer: button1.title(for: .normal) ?? "")
    }
    
    @IBAction func button2(_ sender: UIButton) {
        checkAnswer(selectedAnswer: button2.title(for: .normal) ?? "")
    }
    
    @IBAction func button3(_ sender: UIButton) {
        checkAnswer(selectedAnswer: button3.title(for: .normal) ?? "")
    }
    
    @IBAction func button4(_ sender: UIButton) {
        checkAnswer(selectedAnswer: button4.title(for: .normal) ?? "")
    }
    
    
    func checkAnswer(selectedAnswer: String) {
            guard currentQuestionIndex < questions.count else {
                return
            }
            
            let currentQuestion = questions[currentQuestionIndex]
            if let correctAnswer = currentQuestion["correct_answer"] as? String {
                if selectedAnswer == correctAnswer {
                    print("Doğru cevap!")
                    // Burada doğru cevaba göre yapılacak işlemler eklenebilir
                    scheduleNotification(title: "Doğru Cevap!", body: "Tebrikler, doğru cevapladınız!")
                    correctAnswers += 1
                } else {
                    print("Yanlış cevap!")
                    // Burada yanlış cevaba göre yapılacak işlemler eklenebilir
                    scheduleNotification(title: "Yanlış Cevap!", body: "Üzgünüz, yanlış cevapladınız!")
                    incorrectAnswers += 1
                }
            }
            
            // Sonraki soruya geç
            currentQuestionIndex += 1
            showQuestion()

    }

    func scheduleNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare çalıştı")
        
        if segue.identifier == "sonucEkraniGecis" {
            print("sonucEkraniGecis çalıştı")
            
            if let ResultVC = segue.destination as? ResultVC {
               
                ResultVC.correctAnswers = correctAnswers
                ResultVC.incorrectAnswers = incorrectAnswers
            }
            
        }
    }
}

