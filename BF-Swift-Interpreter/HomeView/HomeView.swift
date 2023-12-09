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
            
            VStack {
                HStack {
                    Button(action: { print("Button 1 tapped") }) {
                        Text("+")
                    }.buttonStyle(BorderedButtonStyle())
                    
                    Button(action: {
                        // Add your action for Button 2 here
                    }) {
                        Text("Button 2")
                    }.buttonStyle(BorderedButtonStyle())
                    
                    Button(action: {
                        // Add your action for Button 3 here
                    }) {
                        Text("Button 3")
                    }.buttonStyle(BorderedButtonStyle())
                    
                    Button(action: {
                        // Add your action for Button 4 here
                    }) {
                        Text("Button 4")
                    }.buttonStyle(BorderedButtonStyle())
                }
            }

        }
    }
}

func print(){
    print("Hey")
}
#Preview {
    HomeView()
}
