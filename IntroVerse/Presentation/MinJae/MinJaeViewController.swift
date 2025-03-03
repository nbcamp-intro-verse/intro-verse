import UIKit
import SnapKit

final class MinJaeViewController: UIViewController {
    private var viewModel = MinJaeViewModel()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MinJae"
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
