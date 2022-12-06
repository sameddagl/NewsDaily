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
    private var actionButton = NDActionButton(title: "Read more", backgroundColor: .systemGray6)
    
    //MARK: - Injections
    private var viewModel: DetailViewModelProtocol!
    
    init(viewModel: DetailViewModelProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    //MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DetailViewController: DetailViewDelagate {
    func handleOutput(_ output: DetaiViewModellOutput) {
        switch output {
        case .load(let articlePresentation):
            articleImageView.sd_setImage(with: URL(string: articlePresentation.urlToImage!), placeholderImage: SFSymbols.placeholderImage)
            titleLabel.text = articlePresentation.title
            sourceNameLabel.text = articlePresentation.sourceName
            descriptionLabel.text = articlePresentation.articleDescription
        case .showWebPage(let url):
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
            make.height.equalTo(600)
        }
    }
    
    func layoutViews() {
        articleImageView.backgroundColor = .red
        articleImageView.contentMode = .scaleToFill
        containerView.addSubview(articleImageView)
        
        let padding: CGFloat = 20
        
        articleImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView)
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(containerView.snp.width).multipliedBy(0.53)
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
    }
    
    
}

