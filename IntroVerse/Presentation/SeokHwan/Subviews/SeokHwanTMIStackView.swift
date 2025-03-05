import UIKit
import SnapKit

final class SeokHwanTMIStackView: UIStackView {
    private var items: [(imageName: String, text: String)] = [
        ("SeokHwanMBTI", "MBTI는 ISTJ입니다!"),
        ("SeokHwanGame", "LOL, Lostark 등 게임하는 것을 좋아해요"),
        ("SeokHwanUniv", "가천대학교 컴퓨터공학과 졸업 🎓"),
        ("SeokHwanLive", "경기도 의왕시 거주중"),
        ("SeokHwanFood", "주로 한식, 일식을 좋아하고, 느끼한 음식은 잘 못먹어요 😇"),
        ("SeokHwanDB", "DB 직무로 인턴십 경험이 있어요 🧑‍💻"),
        ("SeokHwanCode", "조금 추상적이지만 코드를 우아하게 짜는 것을 목표로 합니다! 🤔"),
        ("SeokHwanBaseball", "두산 베어스 팬입니다 ⚾️"),
        ("SeokHwanSports", "해외축구 등 다른 스포츠들 보는 것도 좋아해요 ⚽️🏀🎾⛳️"),
        ("SeokHwanEsports", "LCK, VCT 등 이스포츠 또한 좋아합니다!"),
        ("SeokHwanBlog", "Gatsby로 구축한 블로그를 열심히 꾸미는 중입니다 🔥")
    ]

    convenience init() {
        self.init(frame: .zero)
        configure()
    }
}

private extension SeokHwanTMIStackView {
    func configure() {
        configureLayout()
        addItems()
    }

    func configureLayout() {
        axis = .vertical
        spacing = 16
        distribution = .fill
    }

    func addItems() {
        items.enumerated().forEach { index, item in
            let isImagePositionRight = index % 2 != 0
            let item = SeokHwanTMIItem(imageName: item.imageName,
                                       text: item.text,
                                       isImagePositionRight: isImagePositionRight)
            addArrangedSubview(item)
        }
    }
}
