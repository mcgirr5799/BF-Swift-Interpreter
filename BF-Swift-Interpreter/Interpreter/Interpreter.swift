import Foundation

class Interpreter {
    var cellsAdapter: CellsAdapter
    let inputCode: String
    var outputCode: String = ""
    private var codePointer = 0
    private var instructionPointer = 0
    private var loopIterationCounter = 0
    private let maxLoopIterations = 10000

    init(inputCode: String, cellsAdapter: CellsAdapter) {
        self.inputCode = inputCode
        self.cellsAdapter = cellsAdapter
    }

    private func executeCommand() throws {
        guard codePointer < inputCode.count else { return }

        let command = Array(inputCode)[codePointer]
        print("Executing command: '\(command)' at code position \(codePointer)")

        switch command {
        case ">":
            if cellsAdapter.pointedCellPosition < cellsAdapter.data.count - 1 {
                cellsAdapter.pointedCellPosition += 1
            }
        case "<":
            if cellsAdapter.pointedCellPosition > 0 {
                cellsAdapter.pointedCellPosition -= 1
            }
        case "+":
            cellsAdapter.data[cellsAdapter.pointedCellPosition] = cellsAdapter.data[cellsAdapter.pointedCellPosition] &+ 1
        case "-":
            cellsAdapter.data[cellsAdapter.pointedCellPosition] = cellsAdapter.data[cellsAdapter.pointedCellPosition] &- 1
        case ".":
            if let char = UnicodeScalar(Int(cellsAdapter.data[cellsAdapter.pointedCellPosition])) {
                let character = String(char)
                outputCode += character
            }
        case "[":
            if cellsAdapter.data[cellsAdapter.pointedCellPosition] == 0 {
                // Skip the loop: Find the index of the matching ']' and jump to the next command
                codePointer = try findClosingBracket(for: codePointer) + 1
            } else {
                // Enter the loop: Store this position to return later
                instructionPointer = codePointer + 1
                loopIterationCounter = 0
            }

        case "]":
            if cellsAdapter.data[cellsAdapter.pointedCellPosition] != 0 {
                // Continue the loop: Jump back to the command after the matching '['
                codePointer = instructionPointer + 1
                loopIterationCounter += 1
                if loopIterationCounter > maxLoopIterations {
                    print("Error: Loop iteration limit exceeded")
                    // Handle loop iteration limit exceeded
                }
            } else {
                // Exit the loop: Move to the next command
                codePointer += 1
            }

        default:
            break
        }
            if command != "[" && command != "]" {
            codePointer += 1
        }
    }

    func step() {
        do {
            try executeCommand()
            if codePointer >= inputCode.count {
                print("Interpretation completed. Final output: \(outputCode)")
            }
        } catch InterpreterError.mismatchedBracketsError {
            print("Error: Mismatched brackets")
        } catch InterpreterError.underflowError {
            print("Error: Cell pointer underflow")
        } catch InterpreterError.overflowError {
            print("Error: Cell pointer overflow")
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }


    func interpret() {
        do {
            try checkForMismatchedBrackets()

            cellsAdapter.resetCells()
            codePointer = 0
            instructionPointer = 0
            loopIterationCounter = 0
            outputCode = ""

            while codePointer < inputCode.count {
                try executeCommand()
            }
        } catch InterpreterError.mismatchedBracketsError {
            print("Error: Mismatched brackets")
        } catch InterpreterError.underflowError {
            print("Error: Cell pointer underflow")
        } catch InterpreterError.overflowError {
            print("Error: Cell pointer overflow")
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }

    func checkForMismatchedBrackets() throws {
        var stack: [Int] = []
        for (index, char) in inputCode.enumerated() {
            if char == "[" {
                stack.append(index)
            } else if char == "]" {
                if stack.isEmpty {
                    throw InterpreterError.mismatchedBracketsError
                }
                stack.removeLast()
            }
        }
        if !stack.isEmpty {
            throw InterpreterError.mismatchedBracketsError
        }
    }
    
    private func findClosingBracket(for index: Int) throws -> Int {
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
            // Instead of printing, throw the mismatched brackets error
            throw InterpreterError.mismatchedBracketsError
        }

        return currentIndex - 1
    }

}
