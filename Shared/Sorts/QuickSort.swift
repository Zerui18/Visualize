//
//  QuickSort.swift
//  Visualize
//
//  Created by Zerui Chen on 26/8/20.
//

import Foundation

class QuickSort: GenericSort {
    
    override func execute(steps: Bool) {
        
        func partition(low: Int, high: Int) -> Int {
            var idxSmall = low - 1
            // Pick pivot at centre.
            let idxCentre = (low + high) / 2
            let pivot = sequence.items[idxCentre]
            pause(steps: steps)
            // Swap to side.
            sequence.items.swapAt(idxCentre, high)
            for i in low...(high - 1) {
                if sequence.items[i] < pivot {
                    // Move all smaller than pivot to the left.
                    idxSmall += 1
                    pause(steps: steps)
                    sequence.items.swapAt(idxSmall, i)
                }
            }
            // Move pivot to correct position.
            pause(steps: steps)
            sequence.items.swapAt(idxSmall + 1, high)
            // Return the pivot index.
            return idxSmall + 1
        }
        
        /// The recursive quickSort.
        func quickSort(low: Int, high: Int) {
            if low < high {
                let idxPivot = partition(low: low, high: high)
                
                quickSort(low: low, high: idxPivot - 1)
                quickSort(low: idxPivot + 1, high: high)
            }
        }
        
        quickSort(low: 0, high: sequence.items.count-1)
    }
    
}
