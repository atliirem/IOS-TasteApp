import Foundation

struct MealResponse: Codable {
    let meals: [APIMeal]?
}

struct APIMeal: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strMealThumb: String
    
    let strInstructions: String
    let strArea: String?
    let strTags: String?
}
