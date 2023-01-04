//
//  FavoriteCell.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 4.01.2023.
//

import UIKit
import SDWebImage

final class FavoriteCell: UICollectionViewCell {
    static let reuseID = "FavoriteCell"
    
    private let articleImageView = NDCellImage(frame: .zero)
    private let titleLabel = NDTitleLabel(alignment: .left, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func set(article: ArticlePresentation) {
        titleLabel.text = article.title
        
        if let imageURL = article.urlToImage {
            articleImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
            articleImageView.sd_imageTransition = .fade
            articleImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: SFSymbols.placeholderImage)
        }        
    }
    
    private func configure() {
        addSubview(articleImageView)
        
        articleImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.height.equalTo(articleImageView.snp.width).multipliedBy(0.7)
        }
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(articleImageView)
            make.top.equalTo(articleImageView.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.bottom.lessThanOrEqualTo(self).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
