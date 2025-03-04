import UIKit
import SnapKit

final class SeokHwanViewController: UIViewController {
    private var viewModel = SeokHwanViewModel()

    private let profileImageView = SeokHwanProfileImageView()
    private let headerView = SeokHwanHeaderView()
    private let dividerView = SeokHwanDividerView()
    private let keywordsView = SeokHwanKeywordsView()

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

        view.addSubview(profileImageView)
        view.addSubview(headerView)
        view.addSubview(dividerView)
        view.addSubview(keywordsView)
    }

    func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(profileImageView.snp.width).multipliedBy(0.5625)
        }
        headerView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        keywordsView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
