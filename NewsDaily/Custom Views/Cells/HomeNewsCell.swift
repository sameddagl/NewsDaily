//
//  HomeNewsCell.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import UIKit
import SnapKit
import SDWebImage

final class HomeNewsCell: UITableViewCell {
    static let reuseID = "HomeNewsCell"
    
    private let articleImageView = NDCellImage()
    private let articleTitleLabel = NDTitleLabel(alignment: .left, fontSize: 15)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func set(title: String, imageURL: String?) {
        articleTitleLabel.text = title
        if imageURL != nil {
            articleImageView.sd_setImage(with: URL(string: imageURL!), placeholderImage: nil)
        }
    }
    
    private func configure() {
        addSubview(articleImageView)
        addSubview(articleTitleLabel)
        
        let padding: CGFloat = 20
        
        articleImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(padding)
            make.bottom.equalTo(self).offset(-padding)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
        
        articleTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(padding)
            make.leading.equalTo(articleImageView.snp.trailing).offset(padding)
            make.trailing.equalTo(self).offset(-padding)
            make.bottom.lessThanOrEqualTo(self).offset(-padding)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
