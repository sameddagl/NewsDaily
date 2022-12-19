//
//  DetailViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    //MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let articleImageView = UIImageView()
    private let titleLabel = NDTitleLabel(alignment: .left, fontSize: 20)
    private let descriptionLabel = NDBodyLabel(alignment: .left)
    private let sourceNameLabel = NDSecondaryLabel(alignment: .right)
    private var actionButton = NDActionButton(title: "more_button".localized(with: ""), backgroundColor: .systemGray6)
    
    //MARK: - Injections
    var viewModel: DetailViewModelProtocol!
    
    //MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SDImageCache.shared.clearMemory()
        configureView()
        setupScrollView()
        layoutViews()
        viewModel.delegate = self
        viewModel.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc func readMoreTapped() {
        viewModel.requestWebPage()
    }
}

extension DetailViewController: DetailViewDelagate {
    func handleOutput(_ output: DetaiViewModellOutput) {
        switch output {
        case .load(let articlePresentation):
            if let imageURL = articlePresentation.urlToImage {
                articleImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
                articleImageView.sd_imageTransition = .fade
                articleImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: SFSymbols.placeholderImage)
            }
            
            titleLabel.text = articlePresentation.title
            sourceNameLabel.text = articlePresentation.sourceName
            descriptionLabel.text = articlePresentation.articleDescription
        case .showSafariView(let url):
            showSafariView(with: url)
        }
    }
}

//MARK: - UI Related
extension DetailViewController {
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func setupScrollView() {
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.leading.bottom.trailing.equalTo(view)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    func layoutViews() {
        articleImageView.tintColor = .secondarySystemFill
        articleImageView.contentMode = .scaleAspectFit
        articleImageView.image = SFSymbols.placeholderImage
        containerView.addSubview(articleImageView)
        
        let padding: CGFloat = 20
        
        articleImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView)
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(containerView.snp.width).multipliedBy(0.6)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(articleImageView.snp.bottom).offset(padding)
            make.leading.equalTo(containerView).offset(padding)
            make.trailing.equalTo(containerView).offset(-padding)
        }
        
        descriptionLabel.textColor = .secondaryLabel
        
        containerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(padding)
            make.leading.equalTo(containerView).offset(padding)
            make.trailing.equalTo(containerView).offset(-padding)
        }
        
        containerView.addSubview(sourceNameLabel)
        sourceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(padding)
            make.trailing.equalTo(containerView).offset(-padding)
        }

        actionButton.addTarget(self, action: #selector(readMoreTapped), for: .touchUpInside)

        containerView.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(sourceNameLabel.snp.bottom).offset(padding)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(actionButton.snp.bottom).offset(100)
        }
    }
    
    
}

