import Foundation
import UIKit

struct JiSungViewModel {
    func openGitHub() {
        openURL("https://github.com/meowbutlerdev")
    }

    func openBlog() {
        openURL("https://until.blog/@meowbutlerdev")
    }

    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
