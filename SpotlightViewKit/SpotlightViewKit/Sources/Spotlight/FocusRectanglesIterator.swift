//import UIKit
//
//struct LinkedList<T> {
//    var head: Node<T>
//
//    init(head: Node<T>) {
//        self.head = head
//    }
//}
//
//indirect enum Node<T> {
//    case value(element: T, next: Node<T>)
//    case end
//}
//
//extension Node {
//    func element() -> T? {
//        switch self {
//        case .end:
//            return nil
//        case .value(let element, _):
//            return element
//        }
//    }
//}
//
//struct LinkedListIterator<T>: IteratorProtocol {
//    var current: Node<T>
//
//    mutating func next() -> T? {
//        switch current {
//        case let .value(element, nextNode):
//            current = nextNode
//            return element
//        case .end:
//            return nil
//        }
//    }
//}
//
//extension LinkedList: Sequence {
//    func makeIterator() -> LinkedListIterator<T> {
//        return LinkedListIterator(current: head)
//    }
//}
//
//extension LinkedList {
//
//    init<S: Sequence>(_ seq: S) where S.Iterator.Element == Element {
//        var current = Node<T>.end
//        for element in seq.reversed() {
//            current = Node.value(element: element, next: current)
//        }
//        self.head = current
//    }
//}
//
//extension LinkedList where T == CGRect {
//    init(rects: [T]) {
//        self.init(rects)
//    }
//}
//
//extension LinkedListIterator where T == CGRect {
//
//    var element: T? {
//        return current.element()
//    }
//
//    init(rects: [T]) {
//        let linkedlist = LinkedList(rects)
//        self.init(current: linkedlist.head)
//    }
//}
//
//typealias FocusRectanglesIterator = LinkedListIterator<CGRect>

struct FocusRectanglesIterator: IteratorProtocol {
    typealias Element = Int

    private let _count: Int
    private var _current: Int = 0

    mutating func next() -> Int? {
        if _count == _current {
            return nil
        } else {
            defer {
                _current += 1
            }
            return _current
        }
    }

    init(count: Int) {
        self._count = count
    }
}
