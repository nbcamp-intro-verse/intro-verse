import UIKit
import SnapKit

final class JiSungView: UIView {
    let profileView = JiSungProfileView()
    let buttonBar = JiSungButtonBar()
    let contentView = JiSungContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        let backgroundView = JiSungBackgroundView()
        addSubview(backgroundView)
        addSubview(profileView)
        addSubview(buttonBar)
        addSubview(contentView)

        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }

        profileView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.85)
        }

        buttonBar.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(62)
        }

        contentView.snp.makeConstraints { make in
            make.top.equalTo(buttonBar.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(120)
        }

        contentView.upDateContent(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    }
}
