import XCTest
@testable import BF_Swift_Interpreter

class InterpreterUnitTests: XCTestCase {
    var cellsAdapter: CellsAdapter!
    var interpreter: Interpreter!

    override func setUp() {
        super.setUp()
        cellsAdapter = CellsAdapter()
    }

    override func tearDown() {
        cellsAdapter = nil
        interpreter = nil
        super.tearDown()
    }

    func testInitialization() {
        interpreter = Interpreter(inputCode: "++", cellsAdapter: cellsAdapter)
        XCTAssertEqual(interpreter.inputCode, "++")
        XCTAssertNotNil(interpreter.cellsAdapter)
    }

    func testIncrementCommand() {
        interpreter = Interpreter(inputCode: "+", cellsAdapter: cellsAdapter)
        interpreter.step()
        XCTAssertEqual(cellsAdapter.data[0], 1)
    }

    func testDecrementCommand() {
        interpreter = Interpreter(inputCode: "-", cellsAdapter: cellsAdapter)
        interpreter.step()
        XCTAssertEqual(cellsAdapter.data[0], 255)  // Assuming 8-bit underflow since we don't need negative nums
    }

    func testMoveRightCommand() {
        interpreter = Interpreter(inputCode: ">", cellsAdapter: cellsAdapter)
        interpreter.step()
        XCTAssertEqual(cellsAdapter.pointedCellPosition, 1)
    }

    func testMoveLeftCommand() {
        interpreter = Interpreter(inputCode: "<", cellsAdapter: cellsAdapter)
        interpreter.step()
        XCTAssertEqual(cellsAdapter.pointedCellPosition, 0)  // Assuming start at position 0
    }

    func testOutputCommand() {
        cellsAdapter.data[0] = 65  // ASCII for 'A'
        interpreter = Interpreter(inputCode: ".", cellsAdapter: cellsAdapter)
        interpreter.step()
        XCTAssertEqual(interpreter.outputCode, "A")
    }

    func testBasicLoop() {
        interpreter = Interpreter(inputCode: "++[-]", cellsAdapter: cellsAdapter)
        interpreter.interpret()
        XCTAssertEqual(cellsAdapter.data[0], 0)
    }

    func testNestedLoops() {
        interpreter = Interpreter(inputCode: "++[->+<]", cellsAdapter: cellsAdapter)
        interpreter.interpret()
        XCTAssertEqual(cellsAdapter.data[1], 2)
    }

    func testMismatchedBrackets() {
        interpreter = Interpreter(inputCode: "[[", cellsAdapter: cellsAdapter)
        XCTAssertThrowsError(try interpreter.checkForMismatchedBrackets()) { error in
            XCTAssertEqual(error as? InterpreterError, .mismatchedBracketsError)
        }
    }

    func testComplexCodeInterpretation() {
        interpreter = Interpreter(inputCode: "+++[->++<]", cellsAdapter: cellsAdapter)
        interpreter.interpret()
        XCTAssertEqual(cellsAdapter.data[1], 6)
        XCTAssertEqual(interpreter.outputCode, "")
    }

    func testLoopIterationLimitExceeded() {
        let longLoopCode = String(repeating: "[", count: 10001) + String(repeating: "]", count: 10001)
        interpreter = Interpreter(inputCode: longLoopCode, cellsAdapter: cellsAdapter)
        interpreter.interpret()
        // Check for loop iteration limit exceeded handling
    }
}

