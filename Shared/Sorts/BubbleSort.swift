//
//  BubbleSort.swift
//  Visualize
//
//  Created by Zerui Chen on 26/8/20.
//

import Foundation

class BubbleSort: GenericSort {
    
    override func execute(steps: Bool) {
        var endIndex = sequence.items.count - 2
        var currentIndex = 0
        var swapped = true
        
        while swapped && endIndex >= 0 {
            
            swapped = false
            currentIndex = 0
            
            // Highlight current item being bubbled.
            var currentItem = sequence.items[0]
            currentItem.showBorder = true
            
            while currentIndex <= endIndex {
                if sequence.items[currentIndex] > sequence.items[currentIndex + 1] {
                    currentItem.showBorder = false
                    currentItem = sequence.items[currentIndex]
                    currentItem.showBorder = true
                    // Swap.
                    pause(steps: steps)
                    sequence.items.swapAt(currentIndex, currentIndex + 1)
                    swapped = true
                }
                currentIndex += 1
            }
            
            // Un-highlight.
            currentItem.showBorder = false
            
            // Early stopping.
            if !swapped {
                break
            }
            
            endIndex -= 1
        }
    }
    
}
