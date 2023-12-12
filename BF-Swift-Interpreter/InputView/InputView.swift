import SwiftUI

import SwiftUI

struct InputView: View {
    @Binding var inputCode: String
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

struct InputView_Previews: PreviewProvider {
    @State static var inputCode: String = "Enter code:"

    static var previews: some View {
        InputView(inputCode: $inputCode)
    }
}
