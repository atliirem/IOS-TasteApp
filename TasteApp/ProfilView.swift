import SwiftUI
import FirebaseAuth

struct ProfilView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    let meals: [Meal]
    let favoriteIDs: Set<String>
    var onFavoriteToggle: (Meal) -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                HStack(spacing: 16) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(.orange)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(authViewModel.user?.email ?? "No Email")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("Logged in user")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                )
                
                VStack(spacing: 16) {
                    NavigationLink(destination: MyRecipe()) {
                        ProfileRow(title: "My Recipes", icon: "fork.knife")
                    }
                    
                    NavigationLink(destination: MyListView(
                        meals: meals,
                        favoriteIDs: favoriteIDs,
                        onFavoriteToggle: onFavoriteToggle
                    )) {
                        ProfileRow(title: "Favorilerim", icon: "heart.fill")
                    }
                }
                
                Spacer()
                
                Button {
                    authViewModel.signOut()
                } label: {
                    Text("Logout")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(14)
                }
            }
            .padding()
            .navigationTitle("Profil")
        }
    }
}
