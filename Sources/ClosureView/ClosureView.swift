struct ClosureView<T>: View {
    
    typealias ViewCreator = (T) -> AnyView
    
    var value: T
    
    var constructor: ViewCreator
    
    var body: some View {
        constructor(value)
    }
    
    init(_ value: T, constructor: @escaping ViewCreator) {
        self.constructor = constructor
        self.value = value
    }
}
