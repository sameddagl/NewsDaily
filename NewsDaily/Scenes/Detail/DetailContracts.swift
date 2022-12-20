//
//  DetailContracts.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    var delegate: DetailViewDelagate? { get set }
    func load()
    func requestWebPage()
}

enum DetaiViewModellOutput {
    case load(ArticlePresentation)
    case showSafariView(url: String)
}

protocol DetailViewDelagate: AnyObject {
    func handleOutput(_ output: DetaiViewModellOutput)
}
