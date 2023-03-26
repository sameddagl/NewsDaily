//
//  CategoriesCell.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 26.03.2023.
//

import UIKit
import SDWebImage

final class CategoriesCell: UICollectionViewCell {
    static let reuseID = "CategoriesCell"
    
    private let articleImageView = NDCellImage(frame: .zero)
    private let titleLabel = NDTitleLabel(alignment: .left, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func prepareForReuse() {
        articleImageView.image = SFSymbols.placeholderImage
        titleLabel.text = ""
    }
    
    func set(category: SortOption) {
        titleLabel.text = category.title
        
//        if let imageURL = article.urlToImage {
//            articleImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
//            articleImageView.sd_imageTransition = .fade
//            articleImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: SFSymbols.placeholderImage)
//        }
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
        titleLabel.textAlignment = .center
        
        titleLabel.snp.makeConstraints { make in
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
