import Foundation

struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strArea: String
    let strCategory: String
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
}

extension MealDetail {
    var ingredients: [String] {
        [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
            strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
            strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
            strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        ]
            .compactMap { $0 }
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
    static func fromUserMeal(id: String, name: String, instructions: String, area: String, category: String, ingredients: String) -> MealDetail {
        MealDetail(
            idMeal: id,
            strMeal: name,
            strInstructions: instructions,
            strArea: area,
            strCategory: category,
            strIngredient1: ingredients.isEmpty ? nil : ingredients,
            strIngredient2: nil, strIngredient3: nil,
            strIngredient4: nil, strIngredient5: nil, strIngredient6: nil,
            strIngredient7: nil, strIngredient8: nil, strIngredient9: nil,
            strIngredient10: nil, strIngredient11: nil, strIngredient12: nil,
            strIngredient13: nil, strIngredient14: nil, strIngredient15: nil,
            strIngredient16: nil, strIngredient17: nil, strIngredient18: nil,
            strIngredient19: nil, strIngredient20: nil
        )
    }
}
