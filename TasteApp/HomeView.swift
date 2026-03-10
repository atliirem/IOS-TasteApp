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
            VStack(spacing: 20) {
                
                Image("logo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 190, height: 180)
                    .padding(.top, 40)
                
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
                
                List(filteredFoods, id: \.self) { food in
                    Text(food)
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    HomeView()
}
