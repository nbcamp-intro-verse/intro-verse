import UIKit
import Combine

final class ImageRepository: ImageLoadingProtocol {
    private let cache: ImageCachingProtocol
    
    init(cache: ImageCachingProtocol) {
        self.cache = cache
    }
    
    func loadImageAsset(named: String) -> AnyPublisher<UIImage, Error> {
        if let cachedImage = cache.image(for: named, option: .memory, type: .Assets) {
            return Just(cachedImage)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            // lies
            return Future { promise in
                if let image = UIImage(named: named) {
                    self.cache.setImage(image, for: named, option: .memory, type: .Assets)
                    promise(.success(image))
                } else {
                    promise(.failure(NSError(domain: "ImageRepoManager", code: 0)))
                }
            }
            .eraseToAnyPublisher()
        }
    }
    
    func loadImageNetwork(from url: URL, cahceOption cacheOption: CacheOption) -> AnyPublisher<UIImage, Error> {
        // 확인 필요
        let key = url.absoluteString
        
        if let cachedImage = cache.image(for: key, option: cacheOption, type: .Network) {
            return Just(cachedImage)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .tryMap { data -> UIImage in
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "ImageRepoManager", code: 1)
                }
                return image
            }
            .eraseToAnyPublisher()
    }
    
    func saveImage() {
        
    }
}
