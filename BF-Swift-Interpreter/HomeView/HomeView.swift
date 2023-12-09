//
//  HomeView.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 08-12-2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var bfRawCode: String = ""
    
    var body: some View {
        VStack{
            Text("BF Interpreter")
            
            TextField("Code here: ", text: $bfRawCode)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            ButtonView()
        }
    }
}

func print(){
    print("Hey")
}
#Preview {
    HomeView()
}
