import UIKit
import SnapKit

final class JiSungViewController: UIViewController {
    private let jiSungView = JiSungView()

    override func loadView() {
        view = jiSungView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        jiSungView.delegate = self

        setupInitialSelection()

        jiSungView.buttonBar.onButtonSelected = { [weak self] index in
            self?.updateContent(for: index)
        }
    }

    private func setupInitialSelection() {
        let initialIndex = 0
        jiSungView.buttonBar.activateButton(at: initialIndex)
        updateContent(for: initialIndex)
    }

    private func updateContent(for index: Int) {
        let contentTexts = [
            "공무원은 국민전체에 대한 봉사자이며, 국민에 대하여 책임을 진다. 정부는 회계연도마다 예산안을 편성하여 회계연도 개시 90일전까지 국회에 제출하고, 국회는 회계연도 개시 30일전까지 이를 의결하여야 한다. 형사피해자는 법률이 정하는 바에 의하여 당해 사건의 재판절차에서 진술할 수 있다. 국가원로자문회의의 의장은 직전대통령이 된다. 다만, 직전대통령이 없을 때에는 대통령이 지명한다.\n헌법재판소 재판관은 정당에 가입하거나 정치에 관여할 수 없다.",
            "대한민국의 경제질서는 개인과 기업의 경제상의 자유와 창의를 존중함을 기본으로 한다. 모든 국민은 인간다운 생활을 할 권리를 가진다. 국가는 균형있는 국민경제의 성장 및 안정과 적정한 소득의 분배를 유지하고, 시장의 지배와 경제력의 남용을 방지하며, 경제주체간의 조화를 통한 경제의 민주화를 위하여 경제에 관한 규제와 조정을 할 수 있다./n지방자치단체는 주민의 복리에 관한 사무를 처리하고 재산을 관리하며, 법령의 범위안에서 자치에 관한 규정을 제정할 수 있다. 국가는 지역간의 균형있는 발전을 위하여 지역경제를 육성할 의무를 진다..",
            "대통령은 제1항과 제2항의 처분 또는 명령을 한 때에는 지체없이 국회에 보고하여 그 승인을 얻어야 한다. 모든 국민은 헌법과 법률이 정한 법관에 의하여 법률에 의한 재판을 받을 권리를 가진다. 국가는 균형있는 국민경제의 성장 및 안정과 적정한 소득의 분배를 유지하고, 시장의 지배와 경제력의 남용을 방지하며, 경제주체간의 조화를 통한 경제의 민주화를 위하여 경제에 관한 규제와 조정을 할 수 있다./n저작자·발명가·과학기술자와 예술가의 권리는 법률로써 보호한다. 제1항의 지시를 받은 당해 행정기관은 이에 응하여야 한다. 헌법재판소 재판관의 임기는 6년으로 하며, 법률이 정하는 바에 의하여 연임할 수 있다."
        ]

        if index < contentTexts.count {
            jiSungView.contentView.upDateContent(text: contentTexts[index])
        }
    }
}

extension JiSungViewController: JiSungViewDelegate {
    func didTapGitHub() {
        openURL("https://github.com/meowbutlerdev")
    }

    func didTapBlog() {
        openURL("https://until.blog/@meowbutlerdev")
    }

    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
