import UIKit
import SnapKit

final class SeoYoungViewController: UIViewController {
    private var viewModel = SeoYoungViewModel()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SeoYoung"
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
