//
//  SurveyAnswers.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/21/22.
//

import Foundation

struct SurveyAnswers: Codable {
    let surveyID: String
    let questions: [Question]

    enum CodingKeys: String, CodingKey {
        case surveyID = "survey_id"
        case questions
    }
}

// MARK: - Question
struct Question: Codable {
    let id: String
    let answers: [Answer]
}

// MARK: - Answer
struct Answer: Codable {
    let id: String
    let answer: String?
}
