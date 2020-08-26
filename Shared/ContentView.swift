//
//  ContentView.swift
//  Shared
//
//  Created by Zerui Chen on 25/8/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GridView(withRows: 10, columns: 20, sortingWith: QuickSort.self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 500, height: 500))
    }
}
