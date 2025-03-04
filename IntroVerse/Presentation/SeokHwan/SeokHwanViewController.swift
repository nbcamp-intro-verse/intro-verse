import UIKit
import SnapKit

final class SeokHwanViewController: UIViewController {
    private let viewModel = SeokHwanViewModel()

    private lazy var scrollView = UIScrollView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.alignment = .leading
        return stackView
    }()
    private lazy var profileImageView = SeokHwanProfileImageView()
    private lazy var headerView = SeokHwanHeaderView()
    private lazy var dividerView = SeokHwanDividerView()
    private lazy var keywordsView = SeokHwanKeywordsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension SeokHwanViewController {
    func configure() {
        configureLayout()
        configureConstraints()
    }

    func configureLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(keywordsView)
    }

    func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        stackView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview().inset(30)
        }
        profileImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(profileImageView.snp.width).multipliedBy(0.5625)
        }
        dividerView.snp.makeConstraints { make in
            make.width.equalTo(stackView.snp.width)
        }
    }
}
