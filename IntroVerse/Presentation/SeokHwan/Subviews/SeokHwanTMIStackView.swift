import UIKit
import SnapKit

final class SeokHwanTMIStackView: UIStackView {
    private lazy var keywordView1 = SeokHwanTMIItem()
    private lazy var keywordView2 = SeokHwanTMIItem()
    private lazy var keywordView3 = SeokHwanTMIItem()
    private lazy var keywordView4 = SeokHwanTMIItem()
    private lazy var keywordView5 = SeokHwanTMIItem()
    private lazy var keywordView6 = SeokHwanTMIItem()
    private lazy var keywordView7 = SeokHwanTMIItem()
    private lazy var keywordView8 = SeokHwanTMIItem()

    convenience init() {
        self.init(frame: .zero)
        configure()
    }
}

private extension SeokHwanTMIStackView {
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
