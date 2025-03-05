import UIKit
import SnapKit

final class SeokHwanViewController: UIViewController {
    private let viewModel = SeokHwanViewModel()

    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var profileImageView = SeokHwanProfileImageView()
    private lazy var headerView = SeokHwanHeaderView()
    private lazy var divider = SeokHwanDivider()
    private lazy var tmiStackView = SeokHwanTMIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension SeokHwanViewController {
    func configure() {
        configureLayout()
        configureDelegates()
        configureConstraints()
    }

    func configureLayout() {
        view.backgroundColor = UIColor(named: "SeokHwanBackground")
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(headerView)
        contentView.addSubview(divider)
        contentView.addSubview(tmiStackView)
    }

    func configureDelegates() {
        headerView.delegate = self
    }

    func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(profileImageView.snp.width)
        }
        headerView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(230)
        }
        divider.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        tmiStackView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.width.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
        }
    }
}

extension SeokHwanViewController: SeokHwanLinkButtonDelegate {
    func didTapLinkButton(_ type: LinkButtonType) {
        if let url = URL(string: type.urlString) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
