//
//  NDTitleLabel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import UIKit

final class NDTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(alignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        textAlignment = alignment
        font = .systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure() {
        lineBreakMode = .byTruncatingTail
        numberOfLines = 0
        
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.9
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
