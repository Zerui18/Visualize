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
        self.dgroup = DispatchGroup()
    }
    
    fileprivate final let id: UUID
    final let sequence: ASequence
    final let queue: DispatchQueue
    private final var dgroup: DispatchGroup?
    
    var shouldPause = true
    
    final var isDone: Bool {
        sequence.isSortedAscending
    }
    
    final func start(isTesting: Bool = false) {
        if isTesting {
            dgroup = .init()
            execute(isTesting: true)
            dgroup = nil
            sequence.isSorted = true
        }
        else {
            queue.async {
                self.dgroup = .init()
                self.execute(isTesting: false)
                self.dgroup = nil
                DispatchQueue.main.async {
                    self.sequence.isSorted = true
                }
            }
        }
    }
    
    func execute(isTesting: Bool) {
        fatalError("This method should be overriden by subclasses!")
    }
    
    final func step() {
        dgroup?.leave()
    }
    
    final func pause(isTesting: Bool) {
        if isTesting { return }
        dgroup?.enter()
        dgroup?.wait()
    }
    
    final func test() -> Bool {
        start(isTesting: true)
        return sequence.isSortedAscending
    }
    
}
