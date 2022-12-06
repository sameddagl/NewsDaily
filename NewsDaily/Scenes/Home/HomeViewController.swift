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
    private var news = [HomePresentation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createTableView()
        viewModel.delegate = self
        viewModel.load()
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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .didSelectItem(let title):
            print(title)
        case .pagination:
            break
        case .refreshNews:
            break
        case .didFailWithError(let title, let message):
            print(title, message)
        }
    }
    
    func navigate(to route: HomeViewModelRoute) {
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeNewsCell.reuseID, for: indexPath) as! HomeNewsCell
        let article = news[indexPath.row]
        cell.set(article: article)
        return cell
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "News"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.label
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        header.textLabel?.frame = .init(x: 20, y: 0, width: header.frame.width, height: header.frame.height)
        header.textLabel?.textAlignment = .left
    }
}

//MARK: - UI Related
extension HomeViewController {
    private func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "app_name".localized(with: "")
        view.backgroundColor = .systemBackground
    }
    
    private func createTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeNewsCell.self, forCellReuseIdentifier: HomeNewsCell.reuseID)
        view.addSubview(tableView)
    }
}
