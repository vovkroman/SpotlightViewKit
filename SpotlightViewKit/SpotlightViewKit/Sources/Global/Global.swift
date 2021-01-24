func combine<A, B>(_ value: A, with closure: @escaping (A) -> B) -> () -> B {
    return { closure(value) }
}

func combine<A, B, C>(_ value1: A, _ value2: B, with closure: @escaping (A, B) -> C) -> () -> C {
    return { closure(value1, value2) }
}
