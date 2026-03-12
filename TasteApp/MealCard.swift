import SwiftUI

struct MealCard: View {
    let meal: Meal
    var onTap: () -> Void
    
    var body: some View {
        HStack(spacing:  7) {
            
            Image(meal.image)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(meal.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(meal.category)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .foregroundStyle(.orange)
                    
                    Text("15 min")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
        .onTapGesture {
            onTap()
        }
    }
}
