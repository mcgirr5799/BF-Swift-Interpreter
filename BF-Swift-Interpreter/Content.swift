import SwiftUI

struct Cell {
    var value: Int8
}

class CellsAdapter: ObservableObject {
    @Published var data: [Int8] = Array(repeating: 0, count: 5) // Set your desired count
    @Published var pointedCellPosition: Int = 0
}

struct CellsView: View {
    @StateObject private var cellsAdapter = CellsAdapter()

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(cellsAdapter.data.indices, id: \.self) { index in
                        Text("\(cellsAdapter.data[index])")
                            .frame(width: 50, height: 50) // Adjust the size as needed
                            .padding()
                            .background(cellsAdapter.pointedCellPosition == index ? Color.blue : Color.clear)
                            .foregroundColor(cellsAdapter.pointedCellPosition == index ? Color.white : Color.primary)
                            .onTapGesture {
                                // Handle cell selection if needed
                            }
                    }
                }
                .padding()
            }
            ButtonView()
            Spacer()
        }
    }
}

struct CellsView_Previews: PreviewProvider {
    static var previews: some View {
        CellsView()
    }
}
