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
    private var viewModel: HomeViewModelProtocol!
    
    init(viewModel: HomeViewModelProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    //MARK: - Properties
    private var dataSource: UITableViewDiffableDataSource<Int, ArticlePresentation>!
    private var news = [ArticlePresentation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createTableView()
        configureDataSource()
        viewModel.delegate = self
        viewModel.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode =  .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func sortTapped() {
        viewModel.didSelectToSort()
    }
    
    @objc private func didPullToRefresh() {
        viewModel.didPullToRefresh()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - View Model Outputs
extension HomeViewController: HomeViewDelegate {
    func handleOutputs(_ output: HomeViewModelOutput) {
        switch output {
        case .startLoading:
            showLoadingScreen()
        case .endLoading:
            dismissLoadingScreen()
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
            }
        case .didUploadWithNews(let news):
            SDImageCache.shared.clearMemory()
            self.news = news
            self.updateNews()
        case .didFailWithError(let title, let message):
            print(title, message)
        }
    }
    
    func navigate(to route: HomeViewModelRoute) {
        switch route {
        case .detail(let viewModel):
            let vc = DetailBuilder.make(viewModel: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        case .sort:
            let vc = SortViewController()
            vc.delegate = self
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }
    }
}

extension HomeViewController: SortViewDelegate {
    func didSelectCategory(category: NewsCategories) {
        if !news.isEmpty {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        viewModel.changeCategory(category: category)
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
