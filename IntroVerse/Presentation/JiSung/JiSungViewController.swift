import UIKit
import SnapKit

final class JiSungViewController: UIViewController {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "jisung_profile")
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "박지성"
        label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let githubLabel: UILabel = {
        let label = UILabel()
        label.text = "https://github.com/meowbutlerdev"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()

    private let blogLabel: UILabel = {
        let label = UILabel()
        label.text = "https://until.blog/@meowbutlerdev"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        view.insertSubview(backgroundImageView, at: 0)
        view.addSubview(nameLabel)
        view.addSubview(githubLabel)
        view.addSubview(blogLabel)

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.85)
        }

        githubLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }

        blogLabel.snp.makeConstraints { make in
            make.top.equalTo(githubLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
}
