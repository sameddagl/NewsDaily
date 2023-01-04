//
//  SearchViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit
import SDWebImage

final class SearchViewController: UIViewController {
    private var tableView: UITableView!
    
    var viewModel: SearchViewModelPorotocol!
    
    private var articles = [ArticlePresentation]()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createTableView()
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SDImageCache.shared.clearMemory()
        showEmptyStateView(with: "no_text".localized(), in: self.tableView)
    }
    
    @objc private func didPullToRefresh() {
        viewModel.didPullToRefresh()
    }
}

//MARK: - View Model Outputs
extension SearchViewController: SearchViewDelegate {
    func handleOutputs(_ output: SearchViewModelOutput) {
        switch output {
        case .startLoading:
            showLoadingScreen()
        case .endLoading:
            dismissLoadingScreen()
            tableView.endRefreshOnMainThread()
        case .didUploadWithNews(let news):
            self.articles = news
            tableView.reloadOnMainThread()
        case .showEmptyStateView(let message):
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.tableView)
            }
        case .removeEmptyStateView:
            removeEmptyStateView()
        case .didFailWithError(let title, let message):
            print(title, message)
        }
    }

}

//MARK: - Table View Delegates
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeNewsCell.reuseID, for: indexPath) as! HomeNewsCell
        cell.set(article: articles[indexPath.row])
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        viewModel.selectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = tableView.frame.height
        let offset = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        
        viewModel.pagination(height: height, offset: offset, contentHeight: contentHeight)
    }
}

//MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        self.viewModel.newSearch()
        
        guard let query = searchBar.text?.lowercased(), !query.isEmpty else {
            articles.removeAll()
            tableView.reloadData()
            showEmptyStateView(with: "no_text".localized(), in: self.tableView)
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.viewModel.search(with: query)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        articles.removeAll()
        tableView.reloadData()
        showEmptyStateView(with: "no_text".localized(), in: self.tableView)
    }
}

//MARK: - UI Related
extension SearchViewController {
    private func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        navigationItem.title = "search_title".localized(with: "")
    }
    
    private func configureNavBar() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "place_holder".localized()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func createTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(HomeNewsCell.self, forCellReuseIdentifier: HomeNewsCell.reuseID)
        view.addSubview(tableView)
        
        let refreshConrol = UIRefreshControl()
        refreshConrol.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshConrol
    }
}
