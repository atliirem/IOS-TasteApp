import SwiftUI

struct MealCard: View {
    let meal: Meal

    var body: some View {
        HStack(spacing: 14) {

            CachedAsyncImage(url: URL(string: meal.image))
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(meal.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.black)
                    .lineLimit(2)

                HStack(spacing: 4) {
                    Image(systemName: "tag.fill")
                        .font(.caption2)
                        .foregroundStyle(.black)
                    Text(meal.category)
                        .font(.caption)
                        .foregroundStyle(.black)
                }

                if !meal.area.isEmpty {
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.caption2)
                            .foregroundStyle(.black)
                        Text(meal.area)
                            .font(.caption)
                            .foregroundStyle(.black)
                    }
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.07), radius: 10, x: 0, y: 4)
        )
    }
}
