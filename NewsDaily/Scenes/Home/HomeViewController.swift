//
//  HomeViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import UIKit

class HomeViewController: UIViewController {
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
            print("loading")
        case .endLoading:
            print("endLoading")
        case .didUploadWithNews(let news):
            self.news = news
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = news[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
}
