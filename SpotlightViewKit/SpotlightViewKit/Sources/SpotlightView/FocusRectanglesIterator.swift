
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
