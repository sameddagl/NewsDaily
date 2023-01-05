//
//  UIViewController+Ext.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 6.12.2022.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView?
fileprivate var emptyStateView: NDEmptyStateView?

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
        
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = true
        
        let vc = SFSafariViewController(url: url, configuration: configuration)
        vc.preferredControlTintColor = .label
        
        present(vc, animated: true)
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        DispatchQueue.main.async {
            emptyStateView?.removeFromSuperview()
            
            emptyStateView = NDEmptyStateView(message: message)
            guard let emptyStateView = emptyStateView else { return }
            
            emptyStateView.frame = view.safeAreaLayoutGuide.layoutFrame
            view.addSubview(emptyStateView)
        }
    }
    
    func removeEmptyStateView() {
        DispatchQueue.main.async {
            emptyStateView?.removeFromSuperview()
            emptyStateView = nil
        }
    }
    
    func showCheckmarkView(with message: String, in view: UIView) {
        DispatchQueue.main.async {
            let checkmarkView = NDCheckmarkView(message: message)
            
            containerView = UIView(frame: self.view.bounds)
            guard let containerView = containerView else { return }
            containerView.addSubview(checkmarkView)
            containerView.backgroundColor = .clear
            
            checkmarkView.snp.makeConstraints { make in
                make.center.equalTo(containerView)
            }
            
            self.view.addSubview(containerView)
            
            containerView.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                containerView.alpha = 1
            }
            
            self.dismissCheckmarkView()
        }
    }
    
    func dismissCheckmarkView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                containerView?.alpha = 0
            } completion: { _ in
                containerView?.removeFromSuperview()
                containerView = nil
            }
        }
    }
}
