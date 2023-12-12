//
//  ButtonView.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 08-12-2023.
//

import SwiftUI

struct ButtonView: View {
    @Binding var inputCode: String

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    appendCharacter(">")
                }) {
                    Text(">")
                        .padding()
                        .font(.title)
                }
                    .buttonStyle(BorderedButtonStyle())
                
                Spacer()
                Button(action: {
                    appendCharacter("<")
                }) {
                    Text("<")
                        .padding()
                        .font(.title)
                }
                    .buttonStyle(BorderedButtonStyle())
                
                
                Spacer()
                Button(action: {
                    appendCharacter("+")
                }) {
                    Text("+")
                        .padding()
                        .font(.title)
                }.buttonStyle(BorderedButtonStyle())
                
                Spacer()
                Button(action: {
                    appendCharacter("-")
                }) {
                    Text("-")
                        .padding()
                        .font(.title)
                }.buttonStyle(BorderedButtonStyle())
                
                Spacer()
            }
            
            HStack {
                Spacer()
                Button(action: {
                    appendCharacter("[")
                }) {
                    Text("[")
                        .padding()
                        .font(.title)
                }
                    .buttonStyle(BorderedButtonStyle())
                
                Spacer()
                Button(action: {
                    appendCharacter("]")
                }) {
                    Text("]")
                        .padding()
                        .font(.title)
                }.buttonStyle(BorderedButtonStyle())
                
                Spacer()
                Button(action: {
                    appendCharacter(",")
                }) {
                    Text(",")
                        .padding()
                        .font(.title)
                }.buttonStyle(BorderedButtonStyle())
                
                Spacer()
                Button(action: {
                    appendCharacter(".")
                }) {
                    Text(".")
                        .padding()
                        .font(.title)
                }.buttonStyle(BorderedButtonStyle())
                Spacer()
            }
            
            HStack {
                Button(action: {
                    interpretCode(code: inputCode)
                }) {
                    Text("Compile")
                        .padding()
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }.buttonStyle(BorderedButtonStyle())
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding()
                
                
                Button(action: {
                    backspace()
                }) {
                    Text("←")
                        .padding()
                        .font(.title)
                        .frame(maxWidth: .infinity)
                }.buttonStyle(BorderedButtonStyle())
                    .cornerRadius(10)
                    .padding()
            }
        }

    }
    
    private func appendCharacter(_ char: String) {
            if inputCode == "Enter code:" {
                inputCode = char
            } else {
                inputCode.append(char)
            }
    }
    
    private func backspace() {
            if inputCode == "Enter code:" {
                inputCode.removeAll()
            } else if inputCode.count > 0 {
                inputCode.removeLast()
            }
    }
}

func interpretCode(code: String) {
   // Logic to interpret the code goes here
   print("Interpreting code: \(code)")
   print("Fuck yeah we are printing shit")
}
                   
struct ButtonView_Previews: PreviewProvider {
    @State static var dummyInputCode: String = "Dummy Code"

    static var previews: some View {
        ButtonView(inputCode: $dummyInputCode)
    }
}
