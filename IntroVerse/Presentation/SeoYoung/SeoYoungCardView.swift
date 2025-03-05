//
//  SeoYoungCardView.swift
//  IntroVerse
//
//  Created by hanseoyoung on 3/4/25.
//

import UIKit
import SnapKit

final class CardView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        label.numberOfLines = 5
        label.textAlignment = .center
        return label
    }()

    init(title: String, body: String) {
        super.init(frame: .zero)

        backgroundColor = UIColor(red: 0.851, green: 0.918, blue: 0.992, alpha: 1)
        layer.cornerRadius = 20

        titleLabel.text = title
        bodyLabel.text = body

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(bodyLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(16)
        }

        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }
}
