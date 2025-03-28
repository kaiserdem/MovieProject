

import SwiftUI
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.countLimit = 100 // Максимальна кількість зображень в пам'яті
    }
    
    func get(for key: String) -> UIImage? {
        if let image = cache.object(forKey: key as NSString) {
            return image
        }
        
        // Перевіряємо наявність зображення на диску
        if let diskImage = loadImageFromDisk(with: key) {
            cache.setObject(diskImage, forKey: key as NSString)
            return diskImage
        }
        
        return nil
    }
    
    func set(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
        saveImageToDisk(image, with: key)
    }
    
    private func loadImageFromDisk(with key: String) -> UIImage? {
        let fileManager = FileManager.default
        let filePath = getFilePath(for: key)
        
        if fileManager.fileExists(atPath: filePath.path) {
            return UIImage(contentsOfFile: filePath.path)
        }
        
        return nil
    }
    
    private func saveImageToDisk(_ image: UIImage, with key: String) {
        guard let data = image.pngData() else { return }
        let filePath = getFilePath(for: key)
        
        do {
            try data.write(to: filePath)
        } catch {
            print("Error saving image to disk: \(error)")
        }
    }
    
    private func getFilePath(for key: String) -> URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        let cacheDirectory = urls[0]
        let fileName = key.replacingOccurrences(of: "/", with: "_")
        return cacheDirectory.appendingPathComponent(fileName)
    }
}
