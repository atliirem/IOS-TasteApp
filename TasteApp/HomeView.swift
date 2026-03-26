import SwiftUI

struct HomeView: View {
    
    let meals: [Meal]
    let favoriteIDs: Set<String>
    let isLoading: Bool
    let errorMessage: String
    var onFavoriteToggle: (Meal) -> Void
    
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil
    @State private var showCreateMeal = false
    
    var onCreateMealDismiss: () -> Void
    
    var filteredMeals: [Meal] {
        meals.filter { meal in
            let matchesSearch =
                searchText.isEmpty ||
                meal.name.localizedCaseInsensitiveContains(searchText) ||
                meal.category.localizedCaseInsensitiveContains(searchText)
            
            let matchesCategory =
                selectedCategory == nil ||
                meal.category == selectedCategory
            
            return matchesSearch && matchesCategory
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image("last")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 145)
                        .padding(.top, 2)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        
                        TextField("Search Food", text: $searchText)
                    }
                    .padding()
                    .background(Color(.clear))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1))
                    .padding(.horizontal)
                    
                    HorizontalListView(header: "Categories") { category in
                        if selectedCategory == category.name {
                            selectedCategory = nil
                        } else {
                            selectedCategory = category.name
                        }
                    }
                    
                    if isLoading {
                        ProgressView("Loading meals...")
                            .padding(.top, 30)
                    } else if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else if filteredMeals.isEmpty {
                        Text("No meals found")
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                    } else {
                        VerticalListView(
                            header: "Meals",
                            meals: filteredMeals,
                            favoriteIDs: favoriteIDs,
                            onFavoriteToggle: onFavoriteToggle
                        )
                    }
                }
                .toolbar{
                        Button {
                            showCreateMeal = true
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                .sheet(isPresented: $showCreateMeal, onDismiss: {
                    onCreateMealDismiss()
                }) {
                    CreateMealView()
                }
            }
        }
    }
}

#Preview {
    HomeView(
        meals: [
            Meal(
                id: "1",
                name: "Pizza",
                image: "https://via.placeholder.com/150",
                category: "Fast Food",
                instructions: "Bake it",
                area: "Italian",
                tags: "Cheese"
            ),
            Meal(
                id: "2",
                name: "Burger",
                image: "https://via.placeholder.com/150",
                category: "Fast Food",
                instructions: "Grill it",
                area: "American",
                tags: "Beef"
            ),
            Meal(
                id: "3",
                name: "Sushi",
                image: "https://via.placeholder.com/150",
                category: "Seafood",
                instructions: "Roll it",
                area: "Japanese",
                tags: "Rice,Fish"
            )
        ],
        favoriteIDs: ["1"],
        isLoading: false,
        errorMessage: "",
        onFavoriteToggle: { meal in
            print("Favorite toggled: \(meal.name)")
        },
        onCreateMealDismiss: {
            print("Dismissed")
        }
    )
}
