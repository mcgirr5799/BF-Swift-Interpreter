//
//  CellView.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 11-12-2023.
//

import SwiftUI

struct CellView: View {
    @StateObject private var cellsAdapter = CellsAdapter()
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(cellsAdapter.data.indices, id: \.self) { index in
                    Text("\(cellsAdapter.data[index])")
                        .frame(width: 50, height: 50) // Adjust the size as needed
                        .padding()
                        .background(cellsAdapter.pointedCellPosition == index ? Color.blue : Color.clear)
                        .foregroundColor(cellsAdapter.pointedCellPosition == index ? Color.white : Color.primary)
                        .onTapGesture {
                            // Handle cell selection if needed
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CellView()
}
