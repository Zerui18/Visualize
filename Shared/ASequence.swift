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
                Item(value: value, fractionValue: Double(value) / Double(items))
            }
        self.algoType = algoType
    }
    
    class Item: ObservableObject, Identifiable, Comparable {
    
        init(value: Int, fractionValue: Double) {
            self.value = value
            self.fractionValue = fractionValue
        }
        
        let value: Int
        let fractionValue: Double
        
        var showBorder = false {
            willSet {
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
        }
        
        var color: Color {
            Color(hue: fractionValue, saturation: 1, brightness: 1)
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
