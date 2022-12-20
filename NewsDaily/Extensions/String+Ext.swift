//
//  String+Ext.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

extension String {
    func localized(with comment: String = "") -> String{
        return NSLocalizedString(self, comment: comment)
    }
}
