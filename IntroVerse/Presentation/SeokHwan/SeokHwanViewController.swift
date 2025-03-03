import UIKit
import SnapKit

final class SeokHwanViewController: UIViewController {
    private var viewModel = SeokHwanViewModel()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SeokHwan"
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
