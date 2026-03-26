import SwiftUI

struct CachedAsyncImage: View {
    
    let url: URL?
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
        } else {
            ZStack {
                Color.gray.opacity(0.1)
                ProgressView()
            }
            .onAppear {
                loadImage()
            }
        }
    }
    
    private func loadImage() {
        guard let url = url else { return }
        
        // cache
        if let cached = ImageCache.shared.object(forKey: url as NSURL) {
            self.image = cached
            return
        }
        
        // download
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data,
               let uiImage = UIImage(data: data) {
                
                ImageCache.shared.setObject(uiImage, forKey: url as NSURL)
                
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }.resume()
    }
}
