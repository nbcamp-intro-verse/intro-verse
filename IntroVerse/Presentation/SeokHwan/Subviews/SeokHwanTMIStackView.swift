import UIKit
import SnapKit

final class SeokHwanTMIStackView: UIStackView {
    private var items = [SeokHwanTMIItem]()

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
        spacing = 12
        distribution = .fill
    }

    func addItems() {
        items.append(contentsOf: [
            SeokHwanTMIItem(imageName: "SeokHwanMBTI", text: "MBTI는 ISTJ입니다!"),
            SeokHwanTMIItem(imageName: "SeokHwanGame", text: "LOL, Lostark 등 게임하는 것을 좋아해요"),
            SeokHwanTMIItem(imageName: "SeokHwanUniv", text: "가천대학교 컴퓨터공학과 졸업 🎓"),
            SeokHwanTMIItem(imageName: "SeokHwanLive", text: "경기도 의왕시 거주중"),
            SeokHwanTMIItem(imageName: "SeokHwanFood", text: "주로 한식, 일식을 좋아하고, 느끼한 음식은 잘 못먹어요 😇"),
            SeokHwanTMIItem(imageName: "SeokHwanDB", text: "DB 직무로 인턴십 경험이 있어요 🧑‍💻"),
            SeokHwanTMIItem(imageName: "SeokHwanCode", text: "조금 추상적이지만 코드를 우아하게 짜는 것을 목표로 합니다! 🤔"),
            SeokHwanTMIItem(imageName: "SeokHwanBaseball", text: "두산 베어스 팬입니다 ⚾️"),
            SeokHwanTMIItem(imageName: "SeokHwanSports", text: "해외축구 등 다른 스포츠들 보는 것도 좋아해요 ⚽️🏀🎾⛳️"),
            SeokHwanTMIItem(imageName: "SeokHwanEsports", text: "LCK, VCT 등 이스포츠 또한 좋아합니다!"),
            SeokHwanTMIItem(imageName: "SeokHwanBlog", text: "Gatsby로 구축한 블로그를 열심히 꾸미는 중입니다 🔥"),
        ])

        items.forEach {
            addArrangedSubview($0)
        }
    }
}
