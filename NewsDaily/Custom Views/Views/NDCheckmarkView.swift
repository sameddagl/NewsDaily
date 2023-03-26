//
//  NDCheckmarkView.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.01.2023.
//

import UIKit

final class NDCheckmarkView: UIView {
    private let containerView = UIView()
    private let checkmarkImageView = UIImageView()
    private let messageLabel = NDTitleLabel(alignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        addSubview(containerView)
        
        containerView.backgroundColor = .systemGray
        containerView.alpha = 0.95
        containerView.layer.cornerRadius = 15
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.height.equalTo(150)
        }
        
        containerView.addSubview(checkmarkImageView)
        
        checkmarkImageView.image = SFSymbols.checkmark
        checkmarkImageView.tintColor = .systemGreen
        
        checkmarkImageView.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(containerView).offset(10)
            make.width.height.equalTo(containerView).multipliedBy(0.6)
        }
        
        containerView.addSubview(messageLabel)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .white
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(checkmarkImageView.snp.bottom).offset(10)
            make.leading.equalTo(containerView).offset(10)
            make.trailing.equalTo(containerView).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
