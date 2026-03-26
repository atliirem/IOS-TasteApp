import SwiftUI

struct MealDetailView: View {
    let meal: Meal
    let isFavorite: Bool
    var onFavoriteToggle: () -> Void
    
    @State private var mealDetail: MealDetail? = nil
    @State private var isLoading = false
    @State private var errorMessage: String = ""
    
    private let mealService = MealService()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: meal.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 300)
                } placeholder: {
                    Color.gray.opacity(0.2)
                        .overlay(ProgressView())
                }
                .frame(height: 320)
                .frame(maxWidth: .infinity)
                .clipped()
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text(meal.name)
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Button {
                            onFavoriteToggle()
                        } label: {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .font(.title)
                                .foregroundColor(.orange)
                        }
                    }
                    
                    HStack {
                        Text(meal.category)
                        Text("/")
                        Text(meal.area)
                            .foregroundStyle(.gray)
                    }
                    .foregroundColor(.gray)
                    
                    if isLoading {
                        ProgressView("Loading details...")
                    } else if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else if let mealDetail = mealDetail {
                        
                        if !mealDetail.ingredients.isEmpty {
                            Text("Ingredients")
                                .font(.headline)
                            
                            ForEach(mealDetail.ingredients, id: \.self) { ingredient in
                                Text("• \(ingredient)")
                            }
                        }
                        
                        Text("Instructions")
                            .font(.headline)
                        
                        Text(mealDetail.strInstructions)
                        
                        if !meal.tags.isEmpty {
                            Text("# \(meal.tags)")
                                .font(.subheadline)
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .task {
                do {
                    isLoading = true
                    errorMessage = ""
                    mealDetail = try await mealService.fetchMealDetail(id: meal.id)
                    isLoading = false
                } catch {
                    isLoading = false
                    mealDetail = .fromUserMeal(
                        id: meal.id,
                        name: meal.name,
                        instructions: meal.instructions,
                        area: meal.area,
                        category: meal.category,
                        ingredients: meal.ingredients
                    )
                }
        }
    }
}
