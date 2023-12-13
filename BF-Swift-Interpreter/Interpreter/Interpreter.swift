import Foundation

class Interpreter {
    private var cellsAdapter: CellsAdapter
    private let inputCode: String
    var outputCode: String = ""
    private let maxLoopIterations = 10000  // Limit for loop iterations

    init(inputCode: String, cellsAdapter: CellsAdapter) {
        self.inputCode = inputCode
        self.cellsAdapter = cellsAdapter
    }

    func interpret() {
        cellsAdapter.resetCells()
        
        var instructionPointer = 0
        var codePointer = 0
        var loopIterationCounter = 0
        outputCode = ""

        print("Starting interpretation...")

        while codePointer < inputCode.count {
            let command = Array(inputCode)[codePointer]
            print("Executing command: '\(command)' at code position \(codePointer)")

            switch command {
            case ">":
                if cellsAdapter.pointedCellPosition < cellsAdapter.data.count - 1 {
                    cellsAdapter.pointedCellPosition += 1
                }
                print("Pointer moved to position: \(cellsAdapter.pointedCellPosition)")

            case "<":
                if cellsAdapter.pointedCellPosition > 0 {
                    cellsAdapter.pointedCellPosition -= 1
                }
                print("Pointer moved to position: \(cellsAdapter.pointedCellPosition)")

            case "+":
                cellsAdapter.data[cellsAdapter.pointedCellPosition] = cellsAdapter.data[cellsAdapter.pointedCellPosition] &+ 1
                print("Incremented cell at position \(cellsAdapter.pointedCellPosition) to \(cellsAdapter.data[cellsAdapter.pointedCellPosition])")

            case "-":
                cellsAdapter.data[cellsAdapter.pointedCellPosition] = cellsAdapter.data[cellsAdapter.pointedCellPosition] &- 1
                print("Decremented cell at position \(cellsAdapter.pointedCellPosition) to \(cellsAdapter.data[cellsAdapter.pointedCellPosition])")

            case ".":
                if let char = UnicodeScalar(Int(cellsAdapter.data[cellsAdapter.pointedCellPosition])) {
                    let character = String(char)
                    outputCode += character
                    print("Appended '\(character)' to output. Current output: \(outputCode)")
                }

            case "[":
                if cellsAdapter.data[cellsAdapter.pointedCellPosition] == 0 {
                    codePointer = findClosingBracket(for: codePointer)
                    print("Jumped to closing bracket at position \(codePointer)")
                } else {
                    instructionPointer = codePointer
                }

            case "]":
                if cellsAdapter.data[cellsAdapter.pointedCellPosition] != 0 {
                    codePointer = instructionPointer
                    print("Jumped back to start of loop at position \(codePointer)")
                    loopIterationCounter += 1
                    if loopIterationCounter > maxLoopIterations {
                        print("Error: Loop iteration limit exceeded")
                        return
                    }
                }

            default:
                print("Ignored unrecognized command: '\(command)'")
            }
            codePointer += 1
        }

        print("Interpretation completed. Final output: \(outputCode)")
    }


    private func findClosingBracket(for index: Int) -> Int {
        var counter = 1
        var currentIndex = index + 1

        while currentIndex < inputCode.count && counter > 0 {
            let character = Array(inputCode)[currentIndex]

            if character == "[" {
                counter += 1
            } else if character == "]" {
                counter -= 1
            }

            currentIndex += 1
        }

        if counter != 0 {
            print("Error: Mismatched brackets")
            return index // Return original index to prevent crashing
        }

        return currentIndex - 1
    }
}
