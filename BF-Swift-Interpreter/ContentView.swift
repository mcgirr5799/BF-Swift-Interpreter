//
//  ContentView.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 07-12-2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var username: String = "Shawn"
    var body: some View {
        VStack{
            Text("Welcome \(username)!")
        }
    }
}

#Preview {
    ContentView()
}
