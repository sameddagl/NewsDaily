//
//  NDEmptyStateView.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 13.12.2022.
//

import UIKit

final class NDEmptyStateView: UIView {
    private let messageLabel = NDTitleLabel(alignment: .center, fontSize: 28)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        addSubview(messageLabel)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
                
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(50)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
