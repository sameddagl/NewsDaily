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
    
    //MARK: - Properties
    private var viewModel: HomeViewModelProtocol!
    
    init(viewModel: HomeViewModelProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
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
        cell.set(title: article.title, imageURL: article.urlToImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "News"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.label
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        header.textLabel?.frame = .init(x: 20, y: 0, width: view.frame.width, height: 20)
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

//MARK: - UI Related
extension HomeViewController {
    private func configureView() {
        navigationItem.title = "news_title".localized(with: "")
        view.backgroundColor = .systemBackground
    }
    
    private func createTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 200))
        tableView.register(HomeNewsCell.self, forCellReuseIdentifier: HomeNewsCell.reuseID)
        view.addSubview(tableView)
    }
}
