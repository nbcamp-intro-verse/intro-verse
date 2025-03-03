//
//  CarouselCell.swift
//  Intro-verse
//
//  Created by Seungho Jang on 3/3/25.
//

import Foundation
import UIKit

final class CarouselCardCell : UICollectionViewCell {
    // https://blorenzop.medium.com/swift-carousel-759800aa2952
    // https://ios-development.tistory.com/1021
    // Mark: - SubViewss
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        
    }
}
