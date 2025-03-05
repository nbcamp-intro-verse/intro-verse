import UIKit
import SnapKit

final class JiSungContentView: UIView {
    private let backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 31
        view.layer.masksToBounds = true
        view.alpha = 0.4
        return view
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let contents = [
        """
        안녕하세요! 👋
        저는 AI 개발자로 시작해서 iOS 개발자로 전향하고 있습니다.
        현재 Swift, UIKit, SwiftUI 등을 공부하며 더 나은 iOS 앱을 만들기 위해 노력하고 있어요.

        🛠️ 현재 하고 있는 것

        - 📱 iOS 개발: UIKit 기반으로 앱을 만들고 있고, SwiftUI도 점점 익히는 중!
        - 🚀 프로젝트: 직접 앱을 개발하면서 실력을 키우고 있어요!

        📝 저에 대해 더 알고 싶다면

        - 🎯 목표: 빠르고 효율적인 코드를 작성하는 iOS 개발자가 되는 것!
        - 🔍 관심사: UI/UX 개선, 성능 최적화, 애플 생태계
        - 💡 배운 내용을 정리하고 공유하는 걸 좋아해요!
        """,
        """
        💡 소통을 중요하게 생각합니다.
        iOS 개발을 공부하면서 배운 내용을 정리하고 공유하는 걸 좋아해요. 협업에서도 서로의 지식을 공유하며 성장하는 환경을 중요하게 생각합니다.

        🔍 문제를 깊이 파고들어 해결합니다.
        버그가 발생하거나 개선이 필요한 부분이 있으면, 단순히 해결하는 것에서 그치지 않고 근본적인 원인을 분석하고 최적화하는 과정을 즐깁니다.

        📌 정리된 문서를 선호합니다.
        효율적인 협업을 위해 기록을 남기는 습관을 중요하게 생각합니다. 코드 리뷰, 기능 개발 계획 등을 문서로 정리하여 팀원들과 원활하게 협업합니다.

        🚀 능동적으로 피드백을 주고받습니다.
        더 나은 iOS 앱을 만들기 위해 다양한 피드백을 환영합니다. 적극적으로 의견을 나누고, 팀의 목표를 위해 최적의 솔루션을 함께 고민하는 것을 중요하게 여깁니다.
        """,
        """
        ⚡ 빠르고 효율적인 코드 작성
        최적화된 코드를 고민하며, 불필요한 복잡성을 줄이는 것을 중요하게 생각합니다. Swift 컨벤션을 준수하고, 유지보수하기 쉬운 코드를 작성하려고 노력합니다.

        📱 UIKit & SwiftUI 모두 경험
        UIKit을 중심으로 개발하면서 SwiftUI도 함께 익히고 있습니다. 이를 통해 프로젝트 특성에 맞는 최적의 기술을 선택할 수 있습니다.

        🗂 데이터 모델링과 API 연동에 강점
        단순히 UI를 구현하는 것뿐만 아니라 데이터 흐름과 구조를 고민하며 개발하는 것을 좋아합니다. Core Data, API 연동 등 백엔드와의 연계를 고려한 개발을 할 수 있습니다.

        🎨 UI/UX 개선에 관심이 많음
        애플 생태계에 맞는 깔끔하고 직관적인 UI/UX를 고민하는 것을 좋아합니다. 사용자가 더 좋은 경험을 할 수 있도록 인터페이스를 개선하는 과정이 즐겁습니다.

        ✍️ 지식을 공유하고 기록하는 습관
        새로운 기술을 배울 때 기록하고 정리하는 것을 좋아해요. 이를 통해 단순히 암기하는 것이 아니라 깊이 이해하고 응용할 수 있는 개발자로 성장하고 있습니다.
        """
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(backgroundView)
        addSubview(contentLabel)

        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(200)
        }
    }

    func setActiveContent(at index: Int) {
        guard index >= 0, index < contents.count else { return }
        contentLabel.text = contents[index]
    }
}
