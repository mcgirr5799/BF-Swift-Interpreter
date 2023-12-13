//
//  CellAdapter.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 11-12-2023.
//

import Foundation

struct Cell {
    var value: Int8
}

class CellsAdapter: ObservableObject {
    @Published var data: [Int8] = Array(repeating: 0, count: Constants.MAX_CELL_AMOUNT) // Set your desired count
    @Published var pointedCellPosition: Int = 0
    
    public func resetCells(){
        data = Array(repeating: 0, count: data.count)
        pointedCellPosition = 0
    }
}
