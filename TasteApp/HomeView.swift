import SwiftUI

struct HomeView: View {
    
    @State private var searchText = ""
    @State private var selectedCategory : String? = nil
    
    let foods = ["Pizza", "Burger", "Pasta", "Salad"]
    let meal = [
        Meal(name: "Pizza", image: "pizza", category: "Fast Food"),
        Meal(name: "Ev yemeği ", image: "home", category: "Home Made"),
        Meal(name: "Salata", image: "salata", category: "Salad"),
        Meal(name: "köfte", image: "water", category: "Home Made"),
        Meal(name: "Salata", image: "salata", category: "Salad"),
        Meal(name: "köfte", image: "water", category: "Home Made"),
        Meal(name: "Salata", image: "salata", category: "Salad"),
        Meal(name: "köfte", image: "water", category: "Home Made"),
        
    ]
    var filteredMeals: [Meal] {
        meal.filter { meal in
            let matchesSearch =
            searchText.isEmpty || meal.name.localizedCaseInsensitiveContains(searchText) ||
            meal.category.localizedCaseInsensitiveContains(searchText)
            
            let matchesCategory =
            selectedCategory == nil ||
            meal.category == selectedCategory
            
            return matchesSearch && matchesCategory
        }
        
    }

    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(spacing: 20) {
                    
                    Image("logo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .padding(.top, 20)
                     //   .border(isSelected ? Color.orange : Color.gray, width: 1)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        
                        TextField("Search food", text: $searchText)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
    
                    HorizontalListView( header: "Categories"){ category in
                        if selectedCategory == category.name{
                            selectedCategory = nil
                        }else {
                            selectedCategory = category.name
        
                        }
                        
                        
                    }
                    VerticalListView(header: "Meals" , meals: filteredMeals)
                    
                    //                List(filteredFoods, id: \.self) { food in
                    //                    Text(food)
                    //                }
                        .listStyle(.plain)
                }
            }
        }
    }
}

