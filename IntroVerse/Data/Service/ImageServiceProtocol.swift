import UIKit
import Combine

enum ImageServiceType {
    case Assets
    case Network
}

protocol ImageLoadingProtocol {
    func loadImageAsset(named: String) -> AnyPublisher<UIImage, Error>
    func loadImageNetwork(from url: URL, cahceOption: CacheOption) -> AnyPublisher<UIImage, Error>
}

protocol ImageCachingProtocol {
    func image(for key: String, option: CacheOption, type: ImageServiceType) -> UIImage?
    func setImage(_ image: UIImage, for key: String, option: CacheOption, type: ImageServiceType)
    func removeImage(for key: String, option: CacheOption, type: ImageServiceType)
    func clearCache(option: CacheOption, type: ImageServiceType)
}
