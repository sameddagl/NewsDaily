//
//  UIViewController+Ext.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView?

extension UIViewController {
    func showLoadingScreen() {
        DispatchQueue.main.async {
            let ac = UIActivityIndicatorView(style: .large)
            ac.tintColor = .label
            
            containerView = UIView(frame: self.view.bounds)
            guard let containerView = containerView else { return }
            containerView.addSubview(ac)
            containerView.backgroundColor = .black.withAlphaComponent(0.25)
            
            ac.snp.makeConstraints { make in
                make.center.equalTo(containerView)
            }
            
            self.view.addSubview(containerView)
            
            ac.startAnimating()
        }
    }
    
    func dismissLoadingScreen() {
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showSafariView(with url: String) {
        guard let url = URL(string: url) else { return }
        let vc = SFSafariViewController(url: url)
        vc.preferredControlTintColor = .label
        present(vc, animated: true)
    }
}
