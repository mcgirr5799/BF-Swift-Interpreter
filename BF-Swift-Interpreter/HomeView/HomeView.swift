//
//  HomeView.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 08-12-2023.
//

import SwiftUI

struct HomeView: View {
    @State private var inputCode: String = "Enter code:"
    @State private var outputCode: String = ""
    @StateObject private var cellsAdapter = CellsAdapter()

    var body: some View {
        VStack{
            ScrollView{
                
                Spacer()
                CellView(cellsAdapter: cellsAdapter)
                
                Spacer()
                InputView(inputCode: $inputCode)
                
                Spacer()
                OutputView(outputCode: $outputCode)
            }
            ButtonView(inputCode: $inputCode, outputCode: $outputCode, cellsAdapter: cellsAdapter)
        }
    }
}

#Preview {
    HomeView()
}
