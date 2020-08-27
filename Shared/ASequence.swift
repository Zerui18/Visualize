//
//  ASequence.swift
//  Visualize
//
//  Created by Zerui Chen on 25/8/20.
//

import SwiftUI

class ASequence: ObservableObject, Identifiable {
    
    init(withItems items: Int, sortingWith algoType: GenericSort.Type) {
        self.items = [Int](1...items)
            .shuffled()
            .map { value in
                Item.init(value: value, fractionValue: Double(value) / Double(items))
            }
        self.algoType = algoType
    }
    
    struct Item: Identifiable, Comparable {
        
        let value: Int
        let fractionValue: Double
        
        var color: Color {
            Color(hue: 0.5, saturation: 1, brightness: fractionValue)
        }
        
        var id: Int {
            value
        }
        
        // MARK: Comparable
        static func < (lhs: ASequence.Item, rhs: ASequence.Item) -> Bool {
            lhs.value < rhs.value
        }
        
        static func == (lhs: ASequence.Item, rhs: ASequence.Item) -> Bool {
            lhs.value == rhs.value
        }
    }
    
    private let algoType: GenericSort.Type
    lazy var algo: GenericSort = algoType.init(sequence: self)
    
    // MARK: Psuedo Published
    var items: [Item] {
        willSet {
            // Update is sorted
            isSorted = newValue.isSortedAscending
            // Update observer.
            DispatchQueue.main.async {
                withAnimation {
                    self.objectWillChange.send()
                }
            }
        }
    }
    
    var isSorted = false
    
    var isSortedAscending: Bool {
        items.isSortedAscending
    }
    
    func shuffle() {
        // Randomize items.
        items.shuffle()
        // Reset sort.
        algo = algoType.init(sequence: self)
    }
    
}
