import UIKit
import SnapKit

protocol JiSungContainerViewDelegate: AnyObject {
    func didTapGitHub()
    func didTapBlog()
}

final class JiSungContainerView: UIView {
    weak var delegate: JiSungContainerViewDelegate?

    private let scrollView = UIScrollView()
    private let scrollContainerView = UIView()

    let profileView = JiSungProfileView()
    let buttonBar = JiSungButtonBar()
    let contentView = JiSungContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        profileView.delegate = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        profileView.delegate = self
    }

    private func setupView() {
        let backgroundView = JiSungBackgroundView()
        addSubview(backgroundView)
        addSubview(scrollView)
        scrollView.addSubview(scrollContainerView)

        scrollContainerView.addSubview(profileView)
        scrollContainerView.addSubview(buttonBar)
        scrollContainerView.addSubview(contentView)

        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }

        scrollView.alwaysBounceVertical = true

        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }

        scrollContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        profileView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollContainerView.snp.top).offset(UIScreen.main.bounds.height * 0.3)
        }

        buttonBar.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(62)
        }

        contentView.snp.makeConstraints { make in
            make.top.equalTo(buttonBar.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
            make.height.greaterThanOrEqualTo(200)
        }
    }
}

extension JiSungContainerView: JiSungProfileViewDelegate {
    func didTapGitHub() {
        delegate?.didTapGitHub()
    }

    func didTapBlog() {
        delegate?.didTapBlog()
    }
}
