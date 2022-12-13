//
//  HomeNewsCell.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import UIKit
import SnapKit

final class HomeNewsCell: UITableViewCell {
    static let reuseID = "HomeNewsCell"
    
    private let articleImageView = NDCellImage()
    private let articleTitleLabel = NDTitleLabel(alignment: .left, fontSize: 15)
    private let sourceTitleLabel = NDSecondaryLabel(alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    override func prepareForReuse() {
        articleTitleLabel.text = ""
        sourceTitleLabel.text = ""
        articleImageView.image = SFSymbols.placeholderImage
    }
    
    func set(article: ArticlePresentation) {
        articleTitleLabel.text = article.title
        
        if article.urlToImage != nil {
            appContainer.service.fetchImages(url: article.urlToImage!) { [weak self] image in
                guard let image = image else {
                    print("no image")
                    return
                }
                DispatchQueue.main.async {
                    self?.articleImageView.image = image
                }
            }
        }
        
        sourceTitleLabel.text = article.sourceName
    }
    
    private func configure() {
        addSubview(articleImageView)
        addSubview(articleTitleLabel)
        addSubview(sourceTitleLabel)
        
        let padding: CGFloat = 20
        
        articleImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(padding)
            make.bottom.equalTo(self).offset(-padding)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
        
        sourceTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-5)
            make.leading.equalTo(articleImageView.snp.trailing).offset(padding)
            make.height.equalTo(20)
        }
        
        articleTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(padding)
            make.leading.equalTo(articleImageView.snp.trailing).offset(padding)
            make.trailing.equalTo(self).offset(-padding)
            make.bottom.lessThanOrEqualTo(sourceTitleLabel.snp.top).offset(-padding)
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
