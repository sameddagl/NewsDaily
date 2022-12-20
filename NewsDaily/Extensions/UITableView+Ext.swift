//
//  UITableView+Ext.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 20.12.2022.
//

import UIKit

extension UITableView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func endRefreshOnMainThread() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
}
