import SwiftUI

struct OutputView: View {
    @Binding var output: String
    var body: some View {
        Text(output)
            .padding()
            .background(Color.gray)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

#Preview {
    OutputView(output: .constant(""))
}