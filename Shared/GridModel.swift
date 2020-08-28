//
//  GridModel.swift
//  Visualize
//
//  Created by Zerui Chen on 26/8/20.
//

import Foundation

final class GridModel: ObservableObject {
    
    init(nRows: Int, nColumns: Int) {
        self.nRows = nRows
        self.nColumns = nColumns
        let nQuicksort = nRows / 2
        self.sequences =
            (1...nQuicksort).map {_ in .init(withItems: nColumns, sortingWith: QuickSort.self) }
            + (1...(nRows - nQuicksort)).map { _ in  .init(withItems: nColumns, sortingWith: InsertionSort.self) }
    }
    
    @Published var nRows: Int
    @Published var nColumns: Int
    let sequences: [ASequence]
    
    var shouldBuildDrawingGroup: Bool {
        nRows * nColumns > 500
    }
    
    private var timer: Timer?
    
    func shuffle() {
        sequences.forEach { $0.shuffle() }
    }
    
    func run() {
        // Start if necessary.
        sequences.forEach {
            $0.algo.startIfNecessary()
        }
        // Auto-stepping.
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            self?.step()
        }
    }
    
    func pause() {
        timer?.invalidate()
        timer = nil
    }
    
    func step() {
        sequences.forEach { $0.algo.step() }
    }
    
}
