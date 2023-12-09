
import Ogma

public struct Program {
    public let instructions: [Instruction]

    public init(instructions: [Instruction]) {
        self.instructions = instructions
    }
}

public enum Instruction {
    public struct Loop {
        public let instructions: [Instruction]
    }

    case moveRight
    case moveLeft
    case increase
    case decrease
    case output
    case input
    case loop(Loop)
}

extension Instruction {
    public enum Token {
        case moveRight
        case moveLeft
        case increase
        case decrease
        case output
        case input
        case startLoop
        case stopLoop
    }
}

extension Instruction {
    enum Lexer: GeneratorLexer {
        typealias Token = Instruction.Token

        static let generators: Generators = [
            RegexTokenGenerator(string: ">").map(to: .moveRight),
            RegexTokenGenerator(string: "<").map(to: .moveLeft),
            RegexTokenGenerator(string: "+").map(to: .increase),
            RegexTokenGenerator(string: "-").map(to: .decrease),
            RegexTokenGenerator(string: ".").map(to: .output),
            RegexTokenGenerator(string: ",").map(to: .input),
            RegexTokenGenerator(string: "[").map(to: .startLoop),
            RegexTokenGenerator(string: "]").map(to: .stopLoop),
            RegexTokenGenerator(pattern: #".|\n"#).ignore()
        ]
    }
}

extension Program: Parsable {
    public typealias Token = Instruction.Token

    public static let parser = Instruction.self*.map { Program(instructions: $0) }
}

extension Instruction: Parsable {

    public static let parser = AnyParser<Token, Instruction>.consuming { token in
        switch token {
        case .moveRight:
            return .moveRight
        case .moveLeft:
            return .moveLeft
        case .increase:
            return .increase
        case .decrease:
            return .decrease
        case .output:
            return .output
        case .input:
            return .input
        case .startLoop, .stopLoop:
            return nil
        }
    } || Instruction.Loop.map { .loop($0) }

}

extension Instruction.Loop: Parsable  {
    public typealias Token = Instruction.Token

    public static let parser = (Token.startLoop && Instruction.self* && Token.stopLoop).map { Instruction.Loop(instructions: $0) }
}

class ExecutionContext {
    var input: [Int]
    var output: [Int]
    var cells: [Int]

    var currentPointer: Int {
        didSet {
            guard currentPointer >= 0 else { fatalError("Programm attempted to access unavailable memory") }
            assert(currentPointer <= cells.count)
            if currentPointer == cells.count {
                cells.append(0)
            }
        }
    }

    init(input: [Int]) {
        self.input = input
        output = []
        cells = [0]
        currentPointer = 0
    }
}

extension Instruction {

    func perform(using context: ExecutionContext) {
        switch self {
        case .moveRight:
            context.currentPointer += 1
        case .moveLeft:
            context.currentPointer -= 1
        case .increase:
            context.cells[context.currentPointer] += 1
        case .decrease:
            context.cells[context.currentPointer] -= 1
        case .output:
            context.output.append(context.cells[context.currentPointer])
        case .input:
            let input = context.input.first ?? 0
            context.input = Array(context.input.dropFirst())
            context.cells[context.currentPointer] = input
        case .loop(let loop):
            while context.cells[context.currentPointer] != 0 {
                for instruction in loop.instructions {
                    instruction.perform(using: context)
                }
            }
        }
    }

}
