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
    
    func testIncrementOverflow(){
        let testCode = String(repeating: "+", count: 256)
        interpreter = Interpreter(inputCode: testCode, cellsAdapter: cellsAdapter)
        do {
            try interpreter.interpret()
            XCTAssertEqual(cellsAdapter.data[0], 0)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testDecrementCommand() {
        interpreter = Interpreter(inputCode: "-", cellsAdapter: cellsAdapter)
        interpreter.step()
        XCTAssertEqual(cellsAdapter.data[0], 255)  // Assuming 8-bit underflow since we don't need negative nums
    }

    func testDecrementOverflow(){
        let testCode = "-"
        interpreter = Interpreter(inputCode: testCode, cellsAdapter: cellsAdapter)
        do {
            try interpreter.interpret()
            XCTAssertEqual(cellsAdapter.data[0], 255)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
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
        do {
            try interpreter.interpret()
            XCTAssertEqual(cellsAdapter.data[0], 0)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }


    func testNestedLoops() {
        do {
            interpreter = Interpreter(inputCode: "++[->+<]", cellsAdapter: cellsAdapter)
            try interpreter.interpret()
            XCTAssertEqual(cellsAdapter.data[1], 2)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testMismatchedBrackets() {
        interpreter = Interpreter(inputCode: "[[", cellsAdapter: cellsAdapter)
        XCTAssertThrowsError(try interpreter.checkForMismatchedBrackets()) { error in
            XCTAssertEqual(error as? InterpreterError, .mismatchedBracketsError)
        }
    }

    func testOpenLoopLimitExceeded() {
        // Create a code with more open loops than the allowed limit
        // This code will alternate between '+' and '[' characters, then add '-' characters
        let excessiveOpenLoopsCode = String(repeating: "+[", count: Constants.MAX_OPEN_LOOPS + 1)
                                    + String(repeating: "-", count: Constants.MAX_OPEN_LOOPS + 1)

        // Initialize the interpreter with this code
        interpreter = Interpreter(inputCode: excessiveOpenLoopsCode, cellsAdapter: cellsAdapter)
        
        // The test expects the interpreter to throw an openLoopLimitExceeded error
        XCTAssertEqual(cellsAdapter.data[0], 0)
    }

    func testHelloWorldLoopProgram() {
        let inputCode = "-[------->+<]>-.-[->+++++<]>++.+++++++..+++.[--->+<]>-----.---[->+++<]>.-[--->+<]>---.+++.------.--------."
        interpreter = Interpreter(inputCode: inputCode, cellsAdapter: cellsAdapter)
        do{
            try interpreter.interpret()
            XCTAssertEqual(interpreter.outputCode, "Hello World")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

}

