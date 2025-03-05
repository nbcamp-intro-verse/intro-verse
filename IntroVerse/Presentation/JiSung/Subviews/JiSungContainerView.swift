import UIKit
import SnapKit

final class JiSungContainerView: UIView {
    var onGitHubTap: (() -> Void)?
    var onBlogTap: (() -> Void)?
    var onButtonTap: ((Int) -> Void)?

    private let scrollView = UIScrollView()
    private let scrollContainerView = UIView()
    private let blurBoxView = JiSungBlurBoxView()
    private let profileView = JiSungProfileView()
    private let buttonBarView = JiSungButtonBarView()
    private let contentView = JiSungContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupActions()
    }

    private func setupView() {
        let backgroundView = JiSungBackgroundView()
        addSubview(backgroundView)
        addSubview(scrollView)
        scrollView.addSubview(scrollContainerView)

        scrollContainerView.addSubview(blurBoxView)
        scrollContainerView.addSubview(profileView)
        scrollContainerView.addSubview(buttonBarView)
        scrollContainerView.addSubview(contentView)

        scrollView.alwaysBounceVertical = true

        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        scrollContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        profileView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollContainerView.snp.top).offset(UIScreen.main.bounds.height * 0.3)
        }
        buttonBarView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(62)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(buttonBarView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
            make.height.greaterThanOrEqualTo(200)
        }
        blurBoxView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.top).offset(-20)
            make.bottom.equalTo(contentView.snp.bottom).offset(20)
            make.width.equalToSuperview()
        }
    }

    private func setupActions() {
        profileView.onGitHubTap = { [weak self] in self?.onGitHubTap?() }
        profileView.onBlogTap = { [weak self] in self?.onBlogTap?() }
        buttonBarView.onButtonTap = { [weak self] index in self?.onButtonTap?(index) }
    }

    func updateContent(at index: Int) {
        contentView.updateContent(at: index)
    }
}
