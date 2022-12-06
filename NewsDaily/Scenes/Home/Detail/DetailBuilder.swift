//
//  DetailBuilder.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import Foundation

final class DetailBuilder {
    static func make(viewModel: DetailViewModelProtocol) -> DetailViewController{
        let vc = DetailViewController(viewModel: viewModel)
        return vc
    }
}
