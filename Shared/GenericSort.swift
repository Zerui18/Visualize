//
//  GenericSort.swift
//  Visualize
//
//  Created by Zerui Chen on 26/8/20.
//

import Foundation

class GenericSort {
    
    required init(sequence: ASequence) {
        self.id = UUID()
        self.sequence = sequence
        self.queue = DispatchQueue(label: id.uuidString, qos: .userInteractive)
    }
    
    fileprivate final let id: UUID
    final let sequence: ASequence
    final let queue: DispatchQueue
    private final var dgroup: DispatchGroup?
    
    var hasBegun = false
    
    final var isDone: Bool {
        sequence.isSortedAscending
    }
    
    /// Calls .start only if necessary.
    final func startIfNecessary() {
        if !hasBegun && !sequence.isSorted {
            start(steps: true)
        }
    }
    
    /// Start the sorting process.
    final func start(steps: Bool = true) {
        hasBegun = true
        if !steps {
            dgroup = .init()
            execute(steps: false)
            dgroup = nil
            hasBegun = false
        }
        else {
            queue.async {
                self.dgroup = .init()
                self.execute(steps: true)
                self.dgroup = nil
                self.hasBegun = false
            }
        }
    }
    
    func execute(steps: Bool) {
        fatalError("This method should be overriden by subclasses!")
    }
    
    final func step() {
        startIfNecessary()
        dgroup?.leave()
    }
    
    final func pause(steps: Bool) {
        if !steps { return }
        dgroup?.enter()
        dgroup?.wait()
    }
    
    final func test() -> Bool {
        start(steps: false)
        return sequence.isSortedAscending
    }
    
}
