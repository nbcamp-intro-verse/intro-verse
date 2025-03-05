import UIKit

final class ImageCache: ImageCachingProtocol {
    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let diskCacheDirectory: URL
   
    init() {
        let cacheDirectories = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        diskCacheDirectory = cacheDirectories[0].appendingPathComponent("ImageCache")
        try? fileManager.createDirectory(at: diskCacheDirectory, withIntermediateDirectories: true)
    }
    
    func getImage(for key: String, option: CacheOption, type: ImageServiceType) -> UIImage? {
        switch option {
        case .none:
            return nil
        case .memory:
            return cache.object(forKey: key as NSString)
        case .disk:
            if let memoryImage = cache.object(forKey: key as NSString) {
                return memoryImage
            }
            let fileURL = diskCacheDirectory.appendingPathComponent(key)
            // Search whether file exist in that disk cache dir
            if fileManager.fileExists(atPath: fileURL.path) {
                do {
                    let imageData = try Data(contentsOf: fileURL)
                    if let image = UIImage(data: imageData) {
                        cache.setObject(image, forKey: key as NSString)
                        return image
                    } else {
                        print("Error Unable to convert data to UImage")
                    }
                } catch {
                    print("Error reading file from disk cache: \(error)")
                }
            }
            return nil
        }
    }
    
    func setImage(_ image: UIImage, for key: String, option: CacheOption, type: ImageServiceType) {
        let url = URL(string: key) ?? URL(fileURLWithPath: key)
        let cacheKey = type == .Network ? url.lastPathComponent : key
        switch option {
        case .none:
            break
        case .memory:
            cache.setObject(image, forKey: cacheKey as NSString)
        case .disk:
            cache.setObject(image, forKey: cacheKey as NSString)
            let fileURL = diskCacheDirectory.appendingPathComponent(cacheKey)
            try? image.pngData()?.write(to: fileURL)
        }
    }
    
    func removeImage(for key: String, option: CacheOption, type: ImageServiceType) {
        switch option {
        case .none:
            break
        case .memory:
            cache.removeObject(forKey: key as NSString)
        case .disk:
            cache.removeObject(forKey: key as NSString)
            let fileURL = diskCacheDirectory.appendingPathComponent(key)
            try? fileManager.removeItem(at: fileURL)
        }
    }
    
    func clearCache(option: CacheOption, type: ImageServiceType) {
        switch option {
        case .none:
            break
        case .memory:
            cache.removeAllObjects()
        case .disk:
            cache.removeAllObjects()
            // remove file directory as well
            try? fileManager.removeItem(at: diskCacheDirectory)
            // create new file directory for cache
            try? fileManager.createDirectory(at: diskCacheDirectory, withIntermediateDirectories: true)
        }
    }
}
