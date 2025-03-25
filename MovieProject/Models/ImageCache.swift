

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        // Налаштування ліміту кешу
        cache.countLimit = 100 // Максимальна кількість зображень
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
    }
    
    func set(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func get(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
