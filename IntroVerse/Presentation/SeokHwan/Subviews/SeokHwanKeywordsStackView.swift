import UIKit
import SnapKit

final class SeokHwanKeywordsStackView: UIStackView {
    private lazy var keywordView1 = SeokHwanKeywordView()
    private lazy var keywordView2 = SeokHwanKeywordView()
    private lazy var keywordView3 = SeokHwanKeywordView()
    private lazy var keywordView4 = SeokHwanKeywordView()
    private lazy var keywordView5 = SeokHwanKeywordView()
    private lazy var keywordView6 = SeokHwanKeywordView()
    private lazy var keywordView7 = SeokHwanKeywordView()
    private lazy var keywordView8 = SeokHwanKeywordView()

    convenience init() {
        self.init(frame: .zero)
        configure()
    }
}

private extension SeokHwanKeywordsStackView {
    func configure() {
        axis = .vertical
        spacing = 12
        distribution = .fill

        [keywordView1, keywordView2, keywordView3, keywordView4,
         keywordView5, keywordView6, keywordView7, keywordView8].forEach {
            addArrangedSubview($0)
        }
    }
}
