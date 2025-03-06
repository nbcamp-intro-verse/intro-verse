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
    private let memoView = JiSungMemoView()

    private var activeIndex = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupActions()
        setActiveIndex(at: activeIndex)
        setupTapGesture()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupActions()
        setActiveIndex(at: activeIndex)
        setupTapGesture()
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
        scrollContainerView.addSubview(memoView)

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
        }
        memoView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
        }
        blurBoxView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.top).offset(-200)
            make.bottom.equalTo(memoView.snp.bottom).offset(20)
            make.width.equalToSuperview()
        }

    }

    private func setupActions() {
        profileView.onGitHubTap = { [weak self] in self?.onGitHubTap?() }
        profileView.onBlogTap = { [weak self] in self?.onBlogTap?() }
        buttonBarView.onButtonTap = { [weak self] index in self?.setActiveIndex(at: index) }
    }

    func setActiveIndex(at index: Int) {
        activeIndex = index
        buttonBarView.setActiveButton(at: index)
        contentView.setActiveContent(at: index)
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        endEditing(true)
    }
}
