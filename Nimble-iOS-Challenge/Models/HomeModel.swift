//
//  HomeModel.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/21/22.
//

import Foundation

enum SurveyType: String, Codable {
    case survey = "survey"
}

struct UserDataResponse: Codable {
    let data: UserDataClass?
}

struct UserDataClass: Codable {
    let id, type: String?
    let attributes: UserDataAttributes?
}

struct UserDataAttributes: Codable {
    let email: String?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case email
        case avatarURL = "avatar_url"
    }
}



struct HomeResponse: Codable {
    let data: [HomeDatum]?
    let meta: HomeMeta?
}


struct HomeDatum: Codable {
    let id: String?
    let type: SurveyType?
    let attributes: HomeAttributes?
    let relationships: HomeRelationships?
}


struct HomeAttributes: Codable {
    let title, attributesDescription, thankEmailAboveThreshold, thankEmailBelowThreshold: String?
    let isActive: Bool?
    let coverImageURL: String?
    let createdAt, activeAt: String?
    let inactiveAt: String?
    let surveyType: String?

    enum CodingKeys: String, CodingKey {
        case title
        case attributesDescription = "description"
        case thankEmailAboveThreshold = "thank_email_above_threshold"
        case thankEmailBelowThreshold = "thank_email_below_threshold"
        case isActive = "is_active"
        case coverImageURL = "cover_image_url"
        case createdAt = "created_at"
        case activeAt = "active_at"
        case inactiveAt = "inactive_at"
        case surveyType = "survey_type"
    }
}


struct HomeRelationships: Codable {
    let questions: HomeQuestions?
}


struct HomeQuestions: Codable {
    let data: [HomeQuestionsDatum]?
}


struct HomeQuestionsDatum: Codable {
    let id: String?
    let type: TypeEnum?
}

enum TypeEnum: String, Codable {
    case question = "question"
    case answer = "answer"
}


struct HomeMeta: Codable {
    let page, pages, pageSize, records: Int?

    enum CodingKeys: String, CodingKey {
        case page, pages
        case pageSize = "page_size"
        case records
    }
}


struct EachScreenData {
    let id: String?
    let text: String?
    let answers: [SingleSurveyDatum]?
    let type: String?
    let pick: Pick?
    let imageUrl: String?
    let coverImageURL: String?
    let coverImageOpacity: Double?
}










struct SingleSurveyResponse: Codable {
    let data: SingleSurveyDataClass?
    let included: [SingleSurveyIncluded]?
}

// MARK: - DataClass
struct SingleSurveyDataClass: Codable {
    let id, type: String?
    let attributes: SingleSurveyDataAttributes?
    let relationships: SingleSurveyDataRelationships?
}

// MARK: - DataAttributes
struct SingleSurveyDataAttributes: Codable {
    let title, attributesDescription, thankEmailAboveThreshold, thankEmailBelowThreshold: String?
    let isActive: Bool?
    let coverImageURL: String?
    let createdAt, activeAt: String?
    let inactiveAt: String?
    let surveyType: String?

    enum CodingKeys: String, CodingKey {
        case title
        case attributesDescription = "description"
        case thankEmailAboveThreshold = "thank_email_above_threshold"
        case thankEmailBelowThreshold = "thank_email_below_threshold"
        case isActive = "is_active"
        case coverImageURL = "cover_image_url"
        case createdAt = "created_at"
        case activeAt = "active_at"
        case inactiveAt = "inactive_at"
        case surveyType = "survey_type"
    }
}

// MARK: - DataRelationships
struct SingleSurveyDataRelationships: Codable {
    let questions: SingleSurveyQuestions?
}

// MARK: - Questions
struct SingleSurveyQuestions: Codable {
    let data: [SingleSurveyDatum]?
}

// MARK: - Datum
struct SingleSurveyDatum: Codable {
    let id: String?
    let type: SingleSurveyTypeEnum?
}

enum SingleSurveyTypeEnum: String, Codable {
    case answer = "answer"
    case question = "question"
}

// MARK: - Included
struct SingleSurveyIncluded: Codable {
    let id: String
    let type: SingleSurveyTypeEnum?
    let attributes: SingleSurveyIncludedAttributes?
    let relationships: SingleSurveyIncludedRelationships?
}


struct SingleSurveyIncludedAttributes: Codable {
    let text, helpText: String?
    let displayOrder: Int?
    let shortText: String?
    let pick: Pick?
    let displayType: String?
    let isMandatory: Bool?
    let correctAnswerID: String?
    let facebookProfile: String?
    let twitterProfile: String?
    let imageURL: String?
    let coverImageURL: String?
    let coverImageOpacity: Double?
    let coverBackgroundColor: String?
    let isShareableOnFacebook, isShareableOnTwitter: Bool?
    let fontFace, fontSize: String?
    let tagList: String?
    let inputMaskPlaceholder: String?
    let isCustomerFirstName, isCustomerLastName, isCustomerTitle, isCustomerEmail: Bool?
    let promptCustomAnswer: Bool?
    let weight: String?
    let inputMask: String?
    let dateConstraint, defaultValue: String?
    let responseClass: ResponseClass?
    let referenceIdentifier: String?
    let score: Int?
    let alerts: [String]?

    enum CodingKeys: String, CodingKey {
        case text
        case helpText = "help_text"
        case displayOrder = "display_order"
        case shortText = "short_text"
        case pick
        case displayType = "display_type"
        case isMandatory = "is_mandatory"
        case correctAnswerID = "correct_answer_id"
        case facebookProfile = "facebook_profile"
        case twitterProfile = "twitter_profile"
        case imageURL = "image_url"
        case coverImageURL = "cover_image_url"
        case coverImageOpacity = "cover_image_opacity"
        case coverBackgroundColor = "cover_background_color"
        case isShareableOnFacebook = "is_shareable_on_facebook"
        case isShareableOnTwitter = "is_shareable_on_twitter"
        case fontFace = "font_face"
        case fontSize = "font_size"
        case tagList = "tag_list"
        case inputMaskPlaceholder = "input_mask_placeholder"
        case isCustomerFirstName = "is_customer_first_name"
        case isCustomerLastName = "is_customer_last_name"
        case isCustomerTitle = "is_customer_title"
        case isCustomerEmail = "is_customer_email"
        case promptCustomAnswer = "prompt_custom_answer"
        case weight
        case inputMask = "input_mask"
        case dateConstraint = "date_constraint"
        case defaultValue = "default_value"
        case responseClass = "response_class"
        case referenceIdentifier = "reference_identifier"
        case score, alerts
    }
}

enum DisplayType: String, Codable {
    case intro = "intro"
    case star = "star"
    case heart = "heart"
    case smiley = "smiley"
    case choice = "choice"
    case nps = "nps"
    case textarea = "textarea"
    case textfield = "textfield"
    case outro = "outro"
}

enum SingleSurveyPick: String, Codable {
    case any = "any"
    case none = "none"
    case one = "one"
}

enum SingleSurveyResponseClass: String, Codable {
    case answer = "answer"
    case string = "string"
    case text = "text"
}


struct SingleSurveyIncludedRelationships: Codable {
    let answers: SingleSurveyQuestions?
}


enum Pick: String, Codable {
    case any = "any"
    case none = "none"
    case one = "one"
}



enum ResponseClass: String, Codable {
    case answer = "answer"
    case string = "string"
    case text = "text"
}
