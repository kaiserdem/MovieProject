
import SwiftUI

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        guard let url = url else { return }
        
        let urlString = url.absoluteString
        
        // Перевіряємо кеш
        if let cachedImage = ImageCache.shared.get(for: urlString) {
            print("Loaded image from cache: \(urlString)")
            self.image = cachedImage
            return
        }
        
        // Завантажуємо якщо немає в кеші
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                print("Failed to load image data")
                return
            }
            
            // Зберігаємо в кеш
            ImageCache.shared.set(downloadedImage, for: urlString)
            print("Downloaded and cached image: \(urlString)")
            
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }.resume()
    }
}
