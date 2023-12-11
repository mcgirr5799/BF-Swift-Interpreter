//
//  ButtonView.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 08-12-2023.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { print("Button 1 tapped") }) {
                    Text(">")
                        .padding()
                        .font(.title)
                }
                    .buttonStyle(BorderedButtonStyle())
                
                Spacer()
                
                Button(action: {
                    // Add your action for Button 2 here
                }) {
                    Text("<")
                        .padding()
                        .font(.title)
                }
                    .buttonStyle(BorderedButtonStyle())
                
                
                Spacer()
                Button(action: {
                    // Add your action for Button 3 here
                }) {
                    Text("+")
                        .padding()
                        .font(.title)
                }.buttonStyle(BorderedButtonStyle())
                
                Spacer()
                Button(action: {
                    // Add your action for Button 4 here
                }) {
                    Text("-")
                        .padding()
                        .font(.title)
                }.buttonStyle(BorderedButtonStyle())
                Spacer()
            }
            
            HStack {
                Spacer()
                Button(action: { print("Button 1 tapped") }) {
                    Text("[")
                        .padding()
                        .font(.title)
                }
                    .buttonStyle(BorderedButtonStyle())
                Spacer()
                
                Button(action: {
                    // Add your action for Button 2 here
                }) {
                    Text("]")
                        .padding()
                        .font(.title)
                }.buttonStyle(BorderedButtonStyle())
                
                Spacer()
                Button(action: {
                    // Add your action for Button 3 here
                }) {
                    Text(",")
                        .padding()
                        .font(.title)
                }.buttonStyle(BorderedButtonStyle())
                
                Spacer()
                Button(action: {
                    // Add your action for Button 4 here
                }) {
                    Text(".")
                        .padding()
                        .font(.title)
                }.buttonStyle(BorderedButtonStyle())
                Spacer()
            }
            
            Button(action: {}) {
                Text("Compile")
                    .padding()
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
            }.buttonStyle(BorderedButtonStyle())
                .background(Color.red)
                .cornerRadius(10)
                .padding()
        }

    }
}

#Preview {
    ButtonView()
}
