final class ClosureSpy {
    private(set) var callCount = 0

    func call() {
        callCount += 1
    }
}
