//
//  Array+.swift
//  Visualize
//
//  Created by Zerui Chen on 25/8/20.
//

import Foundation

extension Array where Element: Comparable {
    var isSortedAscending: Bool {
        if count < 2 {
            return true
        }
        for i in 0...(count-2) {
            if self[i] > self[i + 1] {
                return false
            }
        }
        return true
    }
}
