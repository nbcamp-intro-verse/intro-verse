import UIKit
import SnapKit

final class JiSungView: UIView {
    let profileView = JiSungProfileView()
    let buttonBar = JiSungButtonBar()

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
    }
}
