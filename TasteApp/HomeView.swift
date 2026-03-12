import SwiftUI

struct HomeView: View {
    
    @State private var searchText = ""
    
    let foods = ["Pizza", "Burger", "Pasta", "Salad"]
    
    var filteredFoods: [String] {
        if searchText.isEmpty {
            return foods
        } else {
            return foods.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(spacing: 20) {
                    
                    Image("logo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 140)
                        .padding(.top, -20)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        
                        TextField("Search food", text: $searchText)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
    
                    HorizontalListView(header: "Categories")
                    VerticalListView(header: "Meals")
                    
                    //                List(filteredFoods, id: \.self) { food in
                    //                    Text(food)
                    //                }
                        .listStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
