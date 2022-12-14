//
//  HomeViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit
import SDWebImage

final class HomeViewController: UIViewController {
    //MARK: - UI Elements
    private var tableView: UITableView!
    
    //MARK: - Injections
    var viewModel: HomeViewModelProtocol!
    
    //MARK: - Properties
    private var dataSource: UITableViewDiffableDataSource<Int, ArticlePresentation>!
    private var news = [ArticlePresentation]()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        viewModel.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode =  .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Actions
    @objc private func sortTapped() {
        viewModel.didSelectToSort()
    }
    
    @objc private func didPullToRefresh() {
        viewModel.didPullToRefresh()
    }
}

//MARK: - View Model Outputs
extension HomeViewController: HomeViewDelegate {
    func handleOutputs(_ output: HomeOutput) {
        switch output {
        case .startLoading:
            showLoadingScreen()
        case .endLoading:
            dismissLoadingScreen()
            self.tableView.endRefreshOnMainThread()
        case .didUploadWithNews(let news):
            SDImageCache.shared.clearMemory()
            self.news = news
            self.updateNews()
        case .changeCategory:
            if !news.isEmpty {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        case .emptyState(let message):
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
        case .removeEmptyState:
            removeEmptyStateView()
        case .didFailWithError(let title, let message):
            print(title, message)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
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

//MARK: - UI Related
extension HomeViewController {
    private func layout() {
        configureView()
        createTableView()
        configureDataSource()
    }
    
    private func configureView() {
        let rightButton = UIBarButtonItem(image: SFSymbols.sort, style: .done, target: self, action: #selector(sortTapped))
        navigationItem.rightBarButtonItem = rightButton
        
        navigationItem.title = "app_name".localized(with: "")
        view.backgroundColor = .systemBackground
    }
    
    private func createTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.register(HomeNewsCell.self, forCellReuseIdentifier: HomeNewsCell.reuseID)
        view.addSubview(tableView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, ArticlePresentation>(tableView: tableView, cellProvider: { tableView, indexPath, article in
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeNewsCell.reuseID, for: indexPath) as! HomeNewsCell
            cell.set(article: article)
            return cell
        })
    }
    
    private func updateNews() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ArticlePresentation>()
        DispatchQueue.main.async {
            snapshot.appendSections([0])
            snapshot.appendItems(self.news)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
