//
//  BubbleSort.swift
//  Visualize
//
//  Created by Zerui Chen on 26/8/20.
//

import Foundation

class BubbleSort: GenericSort {
    
    override func execute(isTesting: Bool) {
        var endIndex = sequence.items.count - 2
        var currentIndex = 0
        var swapped = true
        
        while swapped && endIndex >= 0 {
            
            swapped = false
            currentIndex = 0
            
            while currentIndex <= endIndex {
                if sequence.items[currentIndex] > sequence.items[currentIndex + 1] {
                    // Swap.
                    pause(isTesting: isTesting)
                    sequence.items.swapAt(currentIndex, currentIndex + 1)
                    swapped = true
                }
                currentIndex += 1
            }
            
            // Early stopping.
            if !swapped {
                break
            }
            
            endIndex -= 1
        }
    }
    
}
