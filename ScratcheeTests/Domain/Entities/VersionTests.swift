@testable import Scratchee
import XCTest

final class VersionTests: XCTestCase {
    func test_givenTwoVersions_whenCompared_thenBehavesCorrectly() {
        let v1 = Version("6.2")
        let v2 = Version("6.1")

        XCTAssertTrue(v1 > v2)
    }

    func test_givenDifferentLengths_whenCompared_thenMissingSegmentsAreZero() {
        let v1 = Version("6.1.1")
        let v2 = Version("6.1")

        XCTAssertTrue(v1 > v2)
    }

    func test_givenEqualVersions_whenCompared_thenReturnsFalse() {
        let v1 = Version("6.1")
        let v2 = Version("6.1")

        XCTAssertFalse(v1 > v2)
        XCTAssertEqual(v1, v2)
    }

    func test_givenShorterVersion_whenCompared_thenStillWorks() {
        let v1 = Version("6.0.1")
        let v2 = Version("6")

        XCTAssertTrue(v1 > v2)
    }
}
