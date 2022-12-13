//
//  SearchViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    private var tableView: UITableView!
    
    var viewModel: SearchViewModelPorotocol!
    
    private var articles = [ArticlePresentation]()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createTableView()
        configureNavBar()
        showEmptyStateView(with: "Please enter some text to search for articles", in: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SDImageCache.shared.clearMemory()
    }
    
    @objc private func didPullToRefresh() {
        viewModel.didPullToRefresh()
    }
}

extension SearchViewController: SearchViewDelegate {
    func handleOutputs(_ output: SearchViewModelOutput) {
        switch output {
        case .startLoading:
            showLoadingScreen()
        case .endLoading:
            dismissLoadingScreen()
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
            }
        case .didUploadWithNews(let news):
            self.articles = news
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .showEmptyStateView(let message):
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
        case .removeEmptyStateView:
            removeEmptyStateView()
        case .didFailWithError(let title, let message):
            print(title, message)
        }
    }
    
    func navigate(to route: SearchViewModelRoute) {
        switch route {
        case .detail(let viewModel):
            let vc = DetailBuilder.make(viewModel: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

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

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        self.viewModel.newSearch()
        
        guard let query = searchBar.text?.lowercased(), !query.isEmpty else {
            articles.removeAll()
            tableView.reloadData()
            showEmptyStateView(with: "Please enter some text to search for articles", in: self.view)
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.viewModel.search(with: query)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        articles.removeAll()
        tableView.reloadData()
        showEmptyStateView(with: "Please enter some text to search for articles", in: self.view)
    }
}

//MARK: - UI Related
extension SearchViewController {
    private func configureView() {
        navigationItem.title = "search_title".localized(with: "")
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavBar() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for an article"
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
