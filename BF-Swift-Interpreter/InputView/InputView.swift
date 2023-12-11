import SwiftUI

struct InputView: View {
    @Binding var input: String
    var body: some View {
        TextField("Input", text: $input)
            .padding()
            .background(Color.gray)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

#Preview {
    InputView(input: .constant(""))
}