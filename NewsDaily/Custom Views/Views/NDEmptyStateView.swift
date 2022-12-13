//
//  NDEmptyStateView.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 13.12.2022.
//

import UIKit

class NDEmptyStateView: UIView {
    
    let messageLabel = NDTitleLabel(alignment: .center, fontSize: 28)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configure() {
        addSubview(messageLabel)
        configureMessageLabel()
    }
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
                
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(50)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
        }
    }
}
