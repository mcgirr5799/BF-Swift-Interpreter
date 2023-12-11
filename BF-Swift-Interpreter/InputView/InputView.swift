import SwiftUI

import SwiftUI

struct InputView: View {
    @State private var inputCode: String = "Enter code:"
    @State private var isEditing: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("Input:")
                .font(.headline) // Makes the title stand out
                .padding(.leading) // Add padding to align with the input box

            HStack {
                Spacer()
                TextEditor(text: $inputCode)
                    .onTapGesture {
                        if !isEditing {
                            inputCode = ""
                            isEditing = true
                        }
                    }
                    .padding()
                    .frame(minHeight: 100)
                    .border(Color.gray, width: 1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
            }
        }
    }
}

#Preview {
    InputView()
}
