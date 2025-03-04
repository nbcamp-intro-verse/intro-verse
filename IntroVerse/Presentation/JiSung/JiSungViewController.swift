import UIKit
import SnapKit

final class JiSungViewController: UIViewController {
    private var viewModel = JiSungViewModel()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "JiSung"
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
