//
//  SortViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import UIKit

protocol SortViewDelegate {
    func didSelectCategory(category: NewsCategories)
}

class SortViewController: UIViewController {
    private var tableView: UITableView!
    private var containerView: UIView!
    private let doneButton = NDActionButton(title: "Done", backgroundColor: .clear)
    
    var delegate: SortViewDelegate!
    private var sorts = ["Top", "World", "Business", "Technology", "Entartainment", "Sports", "Environment", "Food", "Health", "Politics", "Science"]
    private var categories: [NewsCategories] = [.top, .world, .business, .technology, .entertainment, .sports, .environment, .food, .health, .politics, .science]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureContainerView()
        createTableView()
    }
    
    @objc private func doneTapped() {
        dismiss(animated: true)
    }
}

extension SortViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sorts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sorts[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
}

extension SortViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectCategory(category: categories[indexPath.row])
        dismiss(animated: true)
    }
}
//MARK: - UI Related
extension SortViewController {
    private func configureView() {
        view.backgroundColor = .clear
    }
    
    private func configureContainerView() {
        containerView = UIView()
        containerView.backgroundColor = .systemBackground
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(20)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        containerView.layer.cornerRadius = 20
        
        doneButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        doneButton.setTitleColor(.label, for: .normal)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        
        containerView.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(10)
            make.trailing.equalTo(containerView).offset(-10)
        }
    }
    
    private func createTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        containerView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(doneButton.snp.bottom)
            make.leading.trailing.equalTo(containerView)
            make.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
