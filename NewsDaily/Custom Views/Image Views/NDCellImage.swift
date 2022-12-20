//
//  NDCellImage.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import UIKit

final class NDCellImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    private func configure() {
        clipsToBounds = true
        layer.cornerRadius = 20
        
        backgroundColor = .systemBackground
        tintColor = .secondarySystemFill
        
        contentMode = .scaleAspectFill
        
        image = SFSymbols.placeholderImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
