//
//  ASequence.swift
//  Visualize
//
//  Created by Zerui Chen on 25/8/20.
//

import SwiftUI

class ASequence: ObservableObject, Identifiable {
    
    init<AlgoType: GenericSort>(withItems items: Int, sortingWith algoType: AlgoType.Type) {
        self.items = [Int](1...items)
            .shuffled()
            .map { value in
                Item.init(value: value, fractionValue: Double(value) / Double(items))
            }
        self.algo = algoType.init(sequence: self)
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
        
        static func < (lhs: ASequence.Item, rhs: ASequence.Item) -> Bool {
            lhs.value < rhs.value
        }
        
        static func == (lhs: ASequence.Item, rhs: ASequence.Item) -> Bool {
            lhs.value == rhs.value
        }
    }
    
    var algo: GenericSort!
    
    // MARK: Published
    var items: [Item] {
        willSet {
            DispatchQueue.main.async {
                withAnimation {
                    self.objectWillChange.send()
                }
            }
        }
    }
    
    @Published var isSorted = false
    
    var isSortedAscending: Bool {
        items.isSortedAscending
    }
    
}
