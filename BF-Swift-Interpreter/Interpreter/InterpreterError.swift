//
//  InterpreterError.swift
//  BF-Swift-Interpreter
//
//  Created by Patrick Star on 13-12-2023.
//

enum InterpreterError: Error {
    case underflowError
    case overflowError
    case mismatchedBracketsError
}
