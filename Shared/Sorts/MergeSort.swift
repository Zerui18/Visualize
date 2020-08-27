//
//  MergeSort.swift
//  Visualize
//
//  Created by Zerui Chen on 27/8/20.
//

import Foundation

class MergeSort: GenericSort {
    
    override func execute(steps: Bool) {
        
        func mergeSort(low: Int, high: Int) {
            if low >= high { return }
            
            let mid = (low + high) / 2
            
            mergeSort(low: low, high: mid)
            mergeSort(low: mid + 1, high: high)
            
            var sorted = [ASequence.Item]()
            sorted.reserveCapacity(high - low + 1)
            
            var left = sequence.items[low...mid]
            var right = sequence.items[mid+1...high]
            
            while !left.isEmpty && !right.isEmpty {
                if left.first! <= right.first! {
                    sorted.append(left.popFirst()!)
                }
                else {
                    sorted.append(right.popFirst()!)
                }
            }
            
            sorted += left + right

            pause(steps: steps)
            sequence.items.replaceSubrange(low...high, with: sorted)
        }
        
        mergeSort(low: 0, high: sequence.items.count - 1)
    }
    
}
