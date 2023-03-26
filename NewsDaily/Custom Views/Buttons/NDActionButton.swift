//
//  NDActionButton.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import UIKit

final class NDActionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    private func configure() {        
        setTitleColor(.label, for: .normal)
        
        titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
