//
//  ContentView.swift
//  Shared
//
//  Created by Zerui Chen on 25/8/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var isSorting = false
    @State var columns = 10
    @State var algos = [QuickSort.self] * 5 + [BubbleSort.self] * 5
    let model = GridModel(nRows: 10, nColumns: 10)
    
    var body: some View {
        VStack {
            GridView()
                .environmentObject(model)
            
            HStack {
                
                Button("Shuffle") {
                    model.shuffle()
                }
                
                if !isSorting {
                    Button("Run") {
                        model.run()
                        isSorting = true
                    }
                    
                    Button("Step") {
                        model.step()
                    }
                }
                else {
                    Button("Pause") {
                        model.pause()
                        isSorting = false
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 500, height: 500))
    }
}
