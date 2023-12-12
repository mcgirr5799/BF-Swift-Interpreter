//
//  HomeView.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 08-12-2023.
//

import SwiftUI

struct HomeView: View {
    @State private var inputCode: String = "Enter code:"

    var body: some View {
        VStack{
            ScrollView{
                
                Spacer()
                CellView()
                
                Spacer()
                InputView(inputCode: $inputCode)
                
                Spacer()
                OutputView()
            }
            ButtonView(inputCode: $inputCode)
        }
    }
}

#Preview {
    HomeView()
}
