import UIKit
import SnapKit

final class NickViewController: UIViewController {
    private var viewModel = NickViewModel()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Nick"
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
