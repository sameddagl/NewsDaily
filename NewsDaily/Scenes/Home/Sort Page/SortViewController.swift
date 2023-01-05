//
//  SortViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import UIKit

protocol SortViewDelegate: AnyObject {
    func didSelectCategory(category: NewsCategories)
}

final class SortViewController: UIViewController {
    //MARK: - UI Properties
    private var tableView: UITableView!
    private var containerView: UIView!
    private let doneButton = NDActionButton(title: "done".localized(), backgroundColor: .clear)
    
    //MARK: - Properties
    weak var delegate: SortViewDelegate!
    
    private var sorts = SortOption.sorts
    private var categories: [NewsCategories] = [.top, .world, .business, .technology, .entertainment, .sports, .environment, .food, .health, .politics, .science]
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        scrollToSelectedCategory()
    }
    
    //MARK: - Actions
    @objc private func doneTapped() {
        dismiss(animated: true)
    }
    
    private func scrollToSelectedCategory() {
        if let selectedCategory = UserDefaults.standard.object(forKey: "selectedCategory") as? Int {
            sorts[selectedCategory].isSelected = true
            tableView.scrollToRow(at: IndexPath(row: selectedCategory, section: 0), at: .top, animated: true)
        }
        else {
            sorts[0].isSelected = true
        }
    }
}

//MARK: - Table View Delegates
extension SortViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sorts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sorts[indexPath.row].title
        cell.accessoryType = sorts[indexPath.row].isSelected ? .checkmark : .none
        return cell
    }
}

extension SortViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectCategory(category: categories[indexPath.row])
        
        for (index, _) in sorts.enumerated() {
            sorts[index].isSelected = false
        }
        
        sorts[indexPath.row].isSelected.toggle()
        UserDefaults.standard.setValue(indexPath.row, forKey: "selectedCategory")
        
        tableView.reloadData()
        dismiss(animated: true)
    }
}

//MARK: - UI Related
extension SortViewController {
    private func layout() {
        configureView()
        configureContainerView()
        createTableView()
    }
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        containerView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(doneButton.snp.bottom)
            make.leading.trailing.equalTo(containerView)
            make.bottom.equalTo(containerView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
