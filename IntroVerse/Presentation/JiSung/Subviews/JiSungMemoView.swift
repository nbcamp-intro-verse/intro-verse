import UIKit
import SnapKit

final class JiSungMemoView: UIView, UITextViewDelegate {
    private let backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 31
        view.layer.masksToBounds = true
        view.alpha = 0.4
        return view
    }()

    private let memoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .medium)
        textView.backgroundColor = .clear
        textView.textColor = .lightGray
        return textView
    }()

    private let placeholder = "메모를 입력하세요."
    private let userDefaultsKey = "JiSungMemo"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        loadMemo()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        loadMemo()
    }

    private func setupView() {
        addSubview(backgroundView)
        addSubview(memoTextView)

        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        memoTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(100)
        }

        memoTextView.delegate = self

        if memoTextView.text.isEmpty {
            setPlaceholder()
        }
    }

    private func setPlaceholder() {
        memoTextView.text = placeholder
        memoTextView.textColor = .lightGray
    }

    private func removePlaceholder() {
        if memoTextView.text == placeholder {
            memoTextView.text = ""
            memoTextView.textColor = .white
        }
    }

    private func saveMemo(_ memo: String) {
        UserDefaults.standard.set(memo, forKey: userDefaultsKey)
    }

    private func loadMemo() {
        if let savedMemo = UserDefaults.standard.string(forKey: userDefaultsKey), !savedMemo.isEmpty {
            memoTextView.text = savedMemo
            memoTextView.textColor = .white
        } else {
            setPlaceholder()
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        removePlaceholder()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setPlaceholder()
        } else {
            saveMemo(textView.text)
        }
    }
}
