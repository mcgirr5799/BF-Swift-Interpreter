//
//  Item.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 07-12-2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
