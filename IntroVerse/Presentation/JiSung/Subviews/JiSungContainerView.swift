import UIKit
import SnapKit

protocol JiSungContainerViewDelegate: AnyObject {
    func didTapGitHub()
    func didTapBlog()
    func didTapButton(at index: Int)
}

final class JiSungContainerView: UIView {
    weak var delegate: JiSungContainerViewDelegate?

    private let scrollView = UIScrollView()
    private let scrollContainerView = UIView()
    private let blurBoxView = JiSungBlurBoxView()

    let profileView = JiSungProfileView()
    let buttonBarView = JiSungButtonBarView()
    let contentView = JiSungContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        profileView.delegate = self
        buttonBarView.delegate = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        profileView.delegate = self
        buttonBarView.delegate = self
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
}

extension JiSungContainerView: JiSungProfileViewDelegate {
    func didTapGitHub() {
        delegate?.didTapGitHub()
    }

    func didTapBlog() {
        delegate?.didTapBlog()
    }
}

extension JiSungContainerView: JiSungButtonBarViewDelegate {
    func didTapButton(at index: Int) {
        delegate?.didTapButton(at: index)
    }

    func handleButtonTap(at index: Int) {
        contentView.updateContent(at: index)
    }
}
