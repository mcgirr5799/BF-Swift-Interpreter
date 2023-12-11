//
//  HomeView.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 08-12-2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            ScrollView{
                
                Spacer()
                CellView()
                
                Spacer()
                InputView()
                
                Spacer()
                OutputView()
            }
            ButtonView()
        }
    }
}

#Preview {
    HomeView()
}
