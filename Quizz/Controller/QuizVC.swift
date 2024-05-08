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
        
        questionLabel.font = UIFont(name: "BarlowSemiCondensed-Medium.ttf", size: 21)
        
        
        
        
        
        let urlString =  "https://opentdb.com/api.php?amount=10&token=c90eae277bb3666234e4b1d190eed2c83f22198ab1885cb100caaac17047b8c9"
    
        if let url = URL(string: urlString){
            let session = URLSession.shared
            let task = session.dataTask(with: url){(data, response, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else{
                    print("no data")
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
                        print("invalid json")
                    }
                }catch{
                    print("error: \(error.localizedDescription)")
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
            options.shuffle()
            
            if options.count >= 4 {
                button1.setTitle(options[0], for: .normal)
                button2.setTitle(options[1], for: .normal)
                button3.setTitle(options[2], for: .normal)
                button4.setTitle(options[3], for: .normal)
            }
        } else {
            print("Questions over")
            self.performSegue(withIdentifier: "sonucEkraniGecis", sender: (correctAnswers,incorrectAnswers))
            print("correct: \(correctAnswers)")
            print("incorrect: \(incorrectAnswers)")
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
                    print("Correct answer!")
                    scheduleNotification(title: "Doğru Cevap!", body: "Congratulations, you answered correctly!")
                    correctAnswers += 1
                } else {
                    print("Wrong answer!")
                    scheduleNotification(title: "Yanlış Cevap!", body: "Sorry, you answered wrong!")
                    incorrectAnswers += 1
                }
            }
            
           
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
        print("prepare worked")
        
        if segue.identifier == "sonucEkraniGecis" {
            print("sonucEkraniGecis worked")
            
            if let ResultVC = segue.destination as? ResultVC {
               
                ResultVC.correctAnswers = correctAnswers
                ResultVC.incorrectAnswers = incorrectAnswers
            }
            
        }
    }
}

