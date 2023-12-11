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
            Text("BF Interpreter")
            CellView()
            
            ButtonView()
        }
    }
}

#Preview {
    HomeView()
}
