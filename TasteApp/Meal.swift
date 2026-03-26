import Foundation

struct Meal: Identifiable {
    let id: String
    let name: String
    let image: String
    let category: String
    let instructions: String
    let area: String
    let tags: String
    let ingredients: String

    init(id: String, name: String, image: String, category: String, instructions: String, area: String, tags: String, ingredients: String = "") {
        self.id = id
        self.name = name
        self.image = image
        self.category = category
        self.instructions = instructions
        self.area = area
        self.tags = tags
        self.ingredients = ingredients
    }

    init(apiMeal: APIMeal) {
        self.id = apiMeal.idMeal
        self.name = apiMeal.strMeal
        self.image = apiMeal.strMealThumb
        self.category = apiMeal.strCategory
        self.instructions = apiMeal.strInstructions
        self.area = apiMeal.strArea ?? ""
        self.tags = apiMeal.strTags ?? ""
        self.ingredients = ""
    }
}
