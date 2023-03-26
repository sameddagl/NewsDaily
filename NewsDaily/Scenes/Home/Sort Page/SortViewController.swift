//
//  SortViewController.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 26.03.2023.
//

import UIKit

protocol SortViewDelegate: AnyObject {
    func didSelectCategory(category: NewsCategories)
}

final class SortViewController: UIViewController {
    //MARK: - UI Properties
    private var collectionView: UICollectionView!
    
    //MARK: - Properties
    weak var delegate: SortViewDelegate!
    
    private var sorts = SortOption.sorts
    private var categories: [NewsCategories] = [.top, .world, .business, .technology, .entertainment, .sports, .environment, .food, .health, .politics, .science]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    @objc private func doneTapped() {
        dismiss(animated: true)
    }
}

extension SortViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sorts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.reuseID, for: indexPath) as! CategoriesCell
        let article = sorts[indexPath.item]
        cell.set(category: article)
        return cell
    }
}

extension SortViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectCategory(category: categories[indexPath.row])
        dismiss(animated: true)
    }
}

//MARK: - UI Related
extension SortViewController {
    private func layout() {
        configureView()
        configureCollectionView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        title = "categories_title".localized()
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: create2ColumnLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.reuseID)
        view.addSubview(collectionView)
    }
    
    private func create2ColumnLayout() -> UICollectionViewFlowLayout {
        let width = view.frame.width
        let padding: CGFloat = 10
        let itemSpacing: CGFloat = 10
        
        let availableWidth = width - (padding * 2) - (itemSpacing)
        let itemWidth = availableWidth / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = .init(width: itemWidth, height: itemWidth)
        return layout
    }
}

