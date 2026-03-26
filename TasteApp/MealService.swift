import Foundation
import FirebaseFirestore
import FirebaseAuth

struct MealService {
    private let db = Firestore.firestore()

    func fetchMeals() async throws -> [Meal] {
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s="
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(MealResponse.self, from: data)
        return (decodedResponse.meals ?? []).map { Meal(apiMeal: $0) }
    }

    func fetchMealDetail(id: String) async throws -> MealDetail {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        guard let detail = decodedResponse.meals.first else { throw URLError(.badServerResponse) }
        return detail
    }

    func fetchUserMeals() async throws -> [Meal] {
        let snapshot = try await db.collection("meals").getDocuments()
        return snapshot.documents.compactMap { document -> Meal? in
            let data = document.data()
            guard let id = data["id"] as? String,
                  let name = data["name"] as? String,
                  let instructions = data["instructions"] as? String,
                  let category = data["category"] as? String else { return nil }
            return Meal(
                id: id,
                name: name,
                image: data["image"] as? String ?? "",
                category: category,
                instructions: instructions,
                area: data["area"] as? String ?? "",
                tags: data["tags"] as? String ?? "",
                ingredients: data["ingredients"] as? String ?? ""
            )
        }
    }

    func fetchMyMeals() async throws -> [Meal] {
        guard let userID = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await db.collection("meals")
            .whereField("userID", isEqualTo: userID)
            .getDocuments()
        return snapshot.documents.compactMap { document -> Meal? in
            let data = document.data()
            guard let id = data["id"] as? String,
                  let name = data["name"] as? String,
                  let instructions = data["instructions"] as? String,
                  let category = data["category"] as? String else { return nil }
            return Meal(
                id: id,
                name: name,
                image: data["image"] as? String ?? "",
                category: category,
                instructions: instructions,
                area: data["area"] as? String ?? "",
                tags: data["tags"] as? String ?? "",
                ingredients: data["ingredients"] as? String ?? ""
            )
        }
    }

    func createMeal(_ meal: UserMeal) async throws {
        guard let id = meal.id else { throw URLError(.badURL) }
        guard let userID = Auth.auth().currentUser?.uid else { throw URLError(.userAuthenticationRequired) }
        try await db.collection("meals").document(id).setData([
            "id": id,
            "name": meal.name,
            "category": meal.category,
            "image": meal.image ?? "",
            "instructions": meal.instructions,
            "ingredients": meal.ingredient,
            "area": meal.area ?? "",
            "tags": meal.tags ?? "",
            "userID": userID
        ])
    }
}
