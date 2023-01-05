//
//  DetailViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit
import SDWebImage

final class DetailViewController: UIViewController {
    //MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let articleImageView = UIImageView()
    private let titleLabel = NDTitleLabel(alignment: .left, fontSize: 20)
    private let descriptionLabel = NDBodyLabel(alignment: .left)
    private let sourceNameLabel = NDSecondaryLabel(alignment: .right)
    private var actionButton = NDActionButton(title: "more_button".localized(with: ""), backgroundColor: .systemGray6)
    private let saveButton = UIButton()
    
    //MARK: - Injections
    var viewModel: DetailViewModelProtocol!
    
    //MARK: - Life Cycle
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
    
    //MARK: - Actions
    @objc func saveTapped() {
        viewModel.saveTapped(isSelected: saveButton.isSelected)
        saveButton.isSelected.toggle()
    }
    
    @objc func readMoreTapped() {
        viewModel.requestWebPage()
    }
}

//MARK: - View Model Outputs
extension DetailViewController: DetailViewDelagate {
    func handleOutput(_ output: DetaiViewModelOutput) {
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
        case .isSaved(let isSaved):
            saveButton.isSelected = isSaved
        case .showSafariView(let url):
            showSafariView(with: url)
        }
    }
}

//MARK: - UI Related
extension DetailViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        saveButton.setImage(SFSymbols.favorites, for: .normal)
        saveButton.setImage(SFSymbols.favoritesFill, for: .selected)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        saveButton.imageView?.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2)
                
        let saveBarButton = UIBarButtonItem(customView: saveButton)
        
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    private func setupScrollView() {
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
    
    private func layoutViews() {
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

