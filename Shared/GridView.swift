//
//  GridView.swift
//  Visualize
//
//  Created by Zerui Chen on 25/8/20.
//

import SwiftUI

struct GridView: View {
    
    init(withRows rows: Int, columns: Int, sortingWith algo: GenericSort.Type) {
        self.nRows = rows
        self.nColumns = columns
        self.sequences = (1...rows).map {_ in ASequence(withItems: columns, sortingWith: algo) }
    }
    
    let nRows: Int
    let nColumns: Int
    
    let sequences: [ASequence]
    
    var body: some View {
        let body = VStack(spacing: 5) {
            ForEach(sequences) { seq in
                Row(sequence: seq)
            }
        }
        if nRows * nColumns >= 500 {
            body.drawingGroup()
        }
        else {
            body
        }
    }
}

fileprivate struct Row: View {
    
    @ObservedObject var sequence: ASequence
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(sequence.items) { item in
                item.color
            }
        }
        .opacity(sequence.isSorted ? 0.5:1)
        .animation(.linear)
        .onAppear {
            sequence.algo.start()
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                sequence.algo.step()
                // Cleanup when done.
                if sequence.isSorted {
                    timer.invalidate()
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(withRows: 10, columns: 10, sortingWith: BubbleSort.self)
            .previewLayout(.fixed(width: 500, height: 500))
    }
}
