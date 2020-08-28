//
//  InsertionSort.swift
//  Visualize
//
//  Created by Zerui Chen on 28/8/20.
//

import Foundation

class InsertionSort: GenericSort {
    
    override func execute(steps: Bool) {
        for i in 1...sequence.items.count - 1 {
            let key = sequence.items[i]
            
            var j = i - 1
            while j >= 0 && key < sequence.items[j] {
                pause(steps: steps)
                sequence.items.swapAt(j, j + 1)
                j -= 1
            }
        }
    }
    
}
