//
//  CellView.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 11-12-2023.
//

import SwiftUI

struct CellView: View {
    @ObservedObject var cellsAdapter: CellsAdapter
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) { // Ensure scroll indicators are shown
            LazyHStack(spacing: 10) {
                ForEach(cellsAdapter.data.indices, id: \.self) { index in
                    VStack {
                        Text("\(cellsAdapter.data[index])")
                        Spacer()
                        Text("\(index)") // Index indicator at the bottom
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 50, height: 50) // Adjust the size as needed
                    .padding()
                    .background(cellsAdapter.pointedCellPosition == index ? Color.blue : Color.clear)
                    .foregroundColor(cellsAdapter.pointedCellPosition == index ? Color.white : Color.primary)
                    .cornerRadius(10)
                    .onTapGesture {
                        // Handle cell selection if needed
                    }
                }
            }
            .padding()
        }
        .frame(maxHeight: 80) // Adjust the height to control the ScrollView size
        .scrollIndicators(.hidden) // Optionally, hide default scroll indicators if you prefer a cleaner look
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(cellsAdapter: CellsAdapter())
    }
}


