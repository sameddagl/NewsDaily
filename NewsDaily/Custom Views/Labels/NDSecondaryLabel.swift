//
//  NDSecondaryLabel.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import UIKit

final class NDSecondaryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(alignment: NSTextAlignment) {
        self.init(frame: .zero)
        textAlignment = alignment
    }
    
    private func configure() {
        font = .preferredFont(forTextStyle: .subheadline)
        
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        
        textColor = .secondaryLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
