struct Version: Sendable, Comparable {
    private let components: [Int]
    let rawValue: String

    nonisolated init(_ rawValue: String) {
        self.rawValue = rawValue
        components = rawValue
            .split(separator: ".")
            .compactMap { Int($0) }
    }

    nonisolated static func ==(lhs: Version, rhs: Version) -> Bool {
        lhs.components == rhs.components
    }

    nonisolated private func component(at index: Int) -> Int {
        index < components.count ? components[index] : 0
    }

    nonisolated static func < (lhs: Version, rhs: Version) -> Bool {
        let maxCount = max(lhs.components.count, rhs.components.count)

        for i in 0..<maxCount {
            let l = lhs.component(at: i)
            let r = rhs.component(at: i)
            if l != r { return l < r }
        }
        return false
    }
}
