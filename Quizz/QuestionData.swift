//
//  QuestionData.swift
//  Quizz
//
//  Created by Çağatay KALKAN on 7.05.2024.
//

import Foundation

struct QuestionData: Codable{
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
