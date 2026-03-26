import SwiftUI

struct MyRecipe: View {
    private let mealService = MealService()
    @State private var myMeals: [Meal] = []

    var body: some View {
        NavigationStack {
            Group {
                if myMeals.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "fork.knife.circle")
                            .font(.system(size: 60))
                            .foregroundStyle(.orange.opacity(0.5))
                        Text("No recipes yet")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("Create your first meal!")
                            .font(.subheadline)
                            .foregroundStyle(.tertiary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(myMeals, id: \.id) { meal in
                                NavigationLink(destination: MealDetailView(meal: meal, isFavorite: false, onFavoriteToggle: {})) {
                                    MealCard(meal: meal)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("My Recipes")
            .task {
                myMeals = (try? await mealService.fetchMyMeals()) ?? []
            }
        }
    }
}
