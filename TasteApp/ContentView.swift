import SwiftUI

struct ContentView: View {
    
    @State private var meals: [Meal] = []
    @State private var favoriteIDs: Set<String> = []
    private let mealService = MealService()
    @State private var isLoading = false
    @State private var errorMessage: String = ""
    @State private var hasLoaded = false
    private let favoriteKey = "favorite_meal_ids"
    @StateObject private var authViewModel = AuthViewModel()
    
    
    var body: some View {
        if authViewModel.user != nil{
            TabView {
                HomeView(
                    meals: meals,
                    favoriteIDs: favoriteIDs,
                    isLoading: isLoading,
                    errorMessage: errorMessage,
                    onFavoriteToggle: { meal in
                        toggleFavorite(meal)
                    },
                    onCreateMealDismiss: {
                        Task {
                            await loadMeals()
                        }
                    }
                )
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                
                
                MyListView(
                    meals: meals,
                    favoriteIDs: favoriteIDs,
                    onFavoriteToggle: { meal in
                        toggleFavorite(meal)
                    }
                )
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                
                ProfilView(
                    authViewModel:  authViewModel,
                   meals: meals,
                    favoriteIDs:  favoriteIDs,
                    onFavoriteToggle:  toggleFavorite,)
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
            .tint(.orange)
            .onAppear {
                if !hasLoaded {
                    hasLoaded = true
                    loadFavorites()
                    
                    Task {
                        await loadMeals()
                    }
                }
            }
            
        }else {
            LoginView(authViewModel: authViewModel)
        }
    }
        func fetchMeals() async {
            do {
                isLoading = true
                errorMessage = ""
                meals = try await mealService.fetchMeals()
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
                print("API Error", error.localizedDescription)
            }
        }
        
        func toggleFavorite(_ meal: Meal) {
            if favoriteIDs.contains(meal.id) {
                favoriteIDs.remove(meal.id)
            } else {
                favoriteIDs.insert(meal.id)
            }
            saveFavorites()
        }
        
        func saveFavorites() {
            UserDefaults.standard.set(Array(favoriteIDs), forKey:  favoriteKey)    // favoriteIDs tipini set olarak sakladığımız için array'e çevirdik önce çünkü userDefaults direk set saklayamaz.
        }
        
        func loadFavorites() {
            let savedIDs = UserDefaults.standard.stringArray(forKey: favoriteKey) ?? [ ]
            favoriteIDs = Set(savedIDs)
        }
    func loadMeals() async {
        do {
            isLoading = true
            errorMessage = ""
            
            let apiMeals = try await mealService.fetchMeals()
            let userMeals = try await mealService.fetchUserMeals()
            
            meals = apiMeals + userMeals
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
        
        
    }

