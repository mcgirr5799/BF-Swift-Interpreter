import Foundation

class Interpreter {
    var cellsAdapter: CellsAdapter
    let inputCode: String
    var outputCode: String = ""
    private var codePointer = 0
    private var instructionPointer = 0
    private var loopIterationCounter = 0
    private var openLoopsCounter = 0
    private let maxLoopCounter = 0

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
            print("At '[', Cell \(cellsAdapter.pointedCellPosition) value: \(cellsAdapter.data[cellsAdapter.pointedCellPosition])")
            if cellsAdapter.data[cellsAdapter.pointedCellPosition] == 0 {
                let newCodePointer = try findClosingBracket(for: codePointer) + 1
                print("Skipping loop: Moving codePointer from \(codePointer) to \(newCodePointer)")
                codePointer = newCodePointer
            } else {
                print("Entering loop: Setting instructionPointer to \(codePointer)")
                instructionPointer = codePointer
            }

            openLoopsCounter += 1
            print(openLoopsCounter)
            if(openLoopsCounter > Constants.MAX_OPEN_LOOPS){
                throw InterpreterError.openLoopLimitExceeded
            }
        case "]":
            print("At ']', Cell \(cellsAdapter.pointedCellPosition) value: \(cellsAdapter.data[cellsAdapter.pointedCellPosition])")
            if cellsAdapter.data[cellsAdapter.pointedCellPosition] != 0 {
                print("Continuing loop: Moving codePointer back to instructionPointer \(instructionPointer)")
                codePointer = instructionPointer
            } else {
                print("Exiting loop: Incrementing codePointer from \(codePointer) to \(codePointer + 1)")
                codePointer += 1
            }

        default:
            break
        }
        codePointer += 1
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


    func interpret() throws {
        try checkForMismatchedBrackets()

        cellsAdapter.resetCells()
        codePointer = 0
        instructionPointer = 0
        loopIterationCounter = 0
        outputCode = ""

        while codePointer < inputCode.count {
            try executeCommand()
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
        
        print(index , "is the opener")
        while currentIndex < inputCode.count {
            let character = Array(inputCode)[currentIndex]

            if character == "[" {
                counter += 1
            } else if character == "]" {
                counter -= 1
                if counter == 0 {
                    return currentIndex
                }
            }

            currentIndex += 1
        }

        if counter != 0 {
            // If we exit the loop and counter is not zero, it means we have mismatched brackets
            throw InterpreterError.mismatchedBracketsError
        }

        print(currentIndex , "is the closer")
        return currentIndex
    }


}
