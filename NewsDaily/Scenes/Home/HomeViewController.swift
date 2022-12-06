//
//  HomeViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - View Model Outputs
extension HomeViewController: HomeViewDelegate {
    func handleOutputs(_ output: HomeViewModelOutput) {
        switch output {
        case .startLoading:
            self.showLoadingScreen()
        case .endLoading:
            self.dismissLoadingScreen()
        case .didUploadWithNews(let news):
            self.news = news
            self.updateNews()
        case .pagination:
            break
        case .refreshNews:
            break
        case .didFailWithError(let title, let message):
            print(title, message)
        }
    }
    
    func navigate(to route: HomeViewModelRoute) {
        switch route {
        case .detail(let viewModel):
            let vc = DetailBuilder.make(viewModel: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "News"
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        guard let header = view as? UITableViewHeaderFooterView else { return }
//        header.textLabel?.textColor = UIColor.label
//        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        header.textLabel?.frame = .init(x: 20, y: 0, width: header.frame.width, height: header.frame.height)
//        header.textLabel?.textAlignment = .left
//    }
}

//MARK: - UI Related
extension HomeViewController {
    private func configureView() {
        navigationItem.title = "app_name".localized(with: "")
        view.backgroundColor = .systemBackground
    }
    
    private func createTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.register(HomeNewsCell.self, forCellReuseIdentifier: HomeNewsCell.reuseID)
        view.addSubview(tableView)
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, ArticlePresentation>(tableView: tableView, cellProvider: { tableView, indexPath, article in
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeNewsCell.reuseID, for: indexPath) as! HomeNewsCell
            let article = self.news[indexPath.row]
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
