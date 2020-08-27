//
//  GridView.swift
//  Visualize
//
//  Created by Zerui Chen on 25/8/20.
//

import SwiftUI

struct GridView: View {
    
    @EnvironmentObject var model: GridModel
    
    var body: some View {
        let body = VStack(spacing: 5) {
            ForEach(model.sequences) { seq in
                Row(sequence: seq)
            }
        }
        if model.shouldBuildDrawingGroup {
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
    }
}

//struct GridView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridView(withRows: 10, columns: 10, sortingWith: [BubbleSort.self] * 5 + [QuickSort.self] * 5)
//            .previewLayout(.fixed(width: 500, height: 500))
//    }
//}
