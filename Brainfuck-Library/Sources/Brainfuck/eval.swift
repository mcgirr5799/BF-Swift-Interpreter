
import Ogma

public func parse(program: String) throws -> Program {
    return try Program.parse(program, using: Instruction.Lexer.self)
}

public func eval(program: String, input: String? = nil) throws -> String {
    let inputArray = input?.cString(using: .ascii)?.map(Int.init) ?? []
    let output: [Int] = eval(program: try parse(program: program), input: inputArray)
    let bytes = output.map { UInt8(clamping: $0)}
    var nullTerminatedBytes = bytes
    nullTerminatedBytes.append(0)
    return String(cString: nullTerminatedBytes)
}

@discardableResult
public func eval(program: String, input: [Int] = []) throws -> [Int] {
    return eval(program: try parse(program: program), input: input)
}

@discardableResult
public func eval(program: Program, input: [Int] = []) -> [Int] {
    return eval(program: program, input: input).output
}

public func eval(program: Program, input: [Int] = []) -> (output: [Int], memory: [Int]) {
    let context = ExecutionContext(input: input)
    for instruction in program.instructions {
        instruction.perform(using: context)
    }
    return (context.output, context.cells)
}
