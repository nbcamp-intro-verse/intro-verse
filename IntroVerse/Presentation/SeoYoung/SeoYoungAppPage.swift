import UIKit

enum SeoYoungLinkPage: String {
    case gitHub = "https://github.com/seoyounghan"
    case tistory = "https://johello.tistory.com/"
    case linkedIn = "https://www.linkedin.com/in/%EC%84%9C%EC%98%81-%ED%95%9C-a91342240/"
    case labDuck = "https://apps.apple.com/kr/app/labduck/id6503278883?mt=12"
    case pullUpper = "https://apps.apple.com/kr/app/pullupper/id6504814983"
    case steps = "https://apps.apple.com/kr/app/%EA%B3%84%EB%8B%A8%EC%82%AC%EB%9E%91%EB%8B%A8/id6737301392"

    func open() {
        guard let url = URL(string: rawValue) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

final class AppPageTapGestureRecognizer: UITapGestureRecognizer {
    let page: SeoYoungLinkPage
    init(page: SeoYoungLinkPage, target: Any?, action: Selector?) {
        self.page = page
        super.init(target: target, action: action)
    }
}
