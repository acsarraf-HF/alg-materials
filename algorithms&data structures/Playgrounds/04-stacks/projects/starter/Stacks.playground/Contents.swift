import Combine
public struct Stack<Element> {

    private var storage: [Element]

    init() {
        storage = []
    }

    public init(elements: [Element]) {
        self.storage = elements
    }

    public mutating func push(element: Element) {
        storage.append(element)
    }

    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }

    public func peek() -> Element? {
        storage.last
    }

    public func isEmpty() -> Bool {
        peek() == nil
    }
}

extension Stack: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----top-----
        \(storage.map { "\($0)" }.reversed().joined(separator:"\n"))
        ------------
        """
    }
}

example(of: "using a stack") {
    var stack = Stack<Int>()

    stack.push(element: 1)
    stack.push(element: 2)
    stack.push(element: 3)
    stack.push(element: 4)
    print(stack)
    if let poppedElement = stack.pop() {
        assert(4 == poppedElement)
        print("Popped: \(poppedElement)")
    }
    print(stack)
}

example(of: "initialising a stack from an array") {
    let array = ["A", "B", "C", "D"]

    var stack = Stack(elements: array)
    print(stack)
    stack.pop()
}

extension Stack: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Element...) {
    storage = elements
  }
}

example(of: "initialising a stack with array literals") {
    var stack: Stack = [1.0, 2.0, 3.0, 4.0]
    stack.pop()
    print(stack)
}

func reverseArrayUsingStack<Element>(array: [Element]) {
    var stack: Stack = .init(elements: array)
    while !stack.isEmpty() {
        print(stack.pop()!)
    }
}

reverseArrayUsingStack(array: [1, 2, 3])

func checkBalancedParentheses(string: String) -> Bool {
    var stack = Stack<Character>()

    for c in string {
        if c == "(" {
            stack.push(element: c)
        } else if c == ")" {
            if stack.isEmpty() {
                return false
            }
            stack.pop()
        }
    }

    return stack.isEmpty()
}
