import SwiftUI

import SwiftUI

struct OutputView: View {
    @State private var codeOutput: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Output:")
                .font(.headline) // Makes the title stand out
                .padding(.leading) // Add padding to align with the output box

            HStack {
                Spacer()
                Text(codeOutput)
                    .padding()
                    .frame(minHeight: 100)// Ensures a similar height to the input view
                    .frame(maxWidth: .infinity)
                    .border(Color.gray, width: 1)
                    .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded corners
                Spacer()
            }
        }
    }
}

#Preview {
    OutputView()
}

