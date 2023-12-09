//
//  ContentView.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 07-12-2023.
//

import SwiftUI
import SwiftData
import Brainfuck

struct ContentView: View {
    @State private var username: String = "Shawn"
    var body: some View {
        VStack{
            Text("Welcome \(username)!")
            
            Button(action: {
                            // Action to be performed when the button is tapped
                            brainfuckTest()
                        }) {
                            Text("Get Brainfucked!")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
        }
    }
}

func brainfuckTest(){
    let program = """
    ++[---------->+<]>.-[------>+<]>-.+[--->+<]>+++.---[->+++<]>-.-[->+++<]>.-[--->++<]>-.++++++++++.+[---->+<]>+++.[->+++<]>+.-[->+++<]>.+[->+++<]>.++++++++++++..---.[++>---<]>--.++[->+++<]>+.++.+++++++++.------.
    """

    let output: String = try! eval(program: program) // Hello World!\n
    print(output)
}
#Preview {
    ContentView()
}
