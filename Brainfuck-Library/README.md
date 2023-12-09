# Brainfuck.swift
A [Brainfuck](https://esolangs.org/wiki/Brainfuck) interpreter written in Swift.

## Installation
### Swift Package Manager

You can install Brainfuck.swift via [Swift Package Manager](https://swift.org/package-manager/) by adding the following line to your `Package.swift`:

```swift
import PackageDescription

let package = Package(
    [...]
    dependencies: [
        .package(url: "https://github.com/nerdsupremacist/Brainfuck.swift.git", from: "0.1.0"),
    ]
)
```

## Usage

Brainfuck.swift comes with a `parse` and a set of `eval` functions.

You can use the directly with the program as a string:

```swift
let program = """
++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.
"""

let output: String = eval(program: program) // Hello World!\n
print(output)
```

## Contributions
Contributions are welcome and encouraged!

## License
Brainfuck.swift is available under the MIT license. See the LICENSE file for more info.
