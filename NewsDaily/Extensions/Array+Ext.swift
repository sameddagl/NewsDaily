//
//  Array+Ext.swift
//  NewsDaily
//
//  Created by Samed Dağlı on 14.12.2022.
//

import Foundation

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if !result.contains(value){
                print("added ")
                result.append(value)
            }
            else {
                print("duplicate")
            }
        }

        return result
    }
}
