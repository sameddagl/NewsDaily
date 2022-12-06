//
//  DetailViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

class DetailViewController: UIViewController {

    private var viewModel: DetailViewModelProtocol!
    
    init(viewModel: DetailViewModelProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        viewModel.load()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DetailViewController: DetailViewDelagate {
    func handleOutput(_ output: DetaiViewModellOutput) {
        switch output {
        case .load(let articlePresentation):
            print(articlePresentation)
        }
    }
}
