//
//  FuzzyTests.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 28/12/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

import XCTest
@testable import Fuzzy

class FuzzyTests: XCTestCase {

    func testTrueConst() {
        let fuzzyTrue = Fuzzy.`true`
        let literalTrue: Fuzzy = true

        XCTAssertEqual(fuzzyTrue.degreeOfMembership, 1.0)
        XCTAssertEqual(literalTrue.degreeOfMembership, 1.0)
    }

    func testFalse() {
        let fuzzyFalse = Fuzzy.`false`
        let literalFalse: Fuzzy = false

        XCTAssertEqual(fuzzyFalse.degreeOfMembership, 0.0)
        XCTAssertEqual(literalFalse.degreeOfMembership, 0.0)
    }

    func testEquatable() {
        do {
            let fuzzyTrue = Fuzzy.`true`
            let literalTrue: Fuzzy = true
            let fuzzyFalse = Fuzzy.`false`
            let literalFalse: Fuzzy = false

            XCTAssertEqual(fuzzyTrue, literalTrue)
            XCTAssertEqual(fuzzyFalse, literalFalse)
        }

        do {
            let fuzzyA: Fuzzy = 0.5
            let fuzzyB = Fuzzy(0.5)

            XCTAssertEqual(fuzzyA, fuzzyB)
        }
    }

    func testComparable() {
        let fuzzyTrue = Fuzzy.`true`
        let fuzzyFalse = Fuzzy.`false`

        XCTAssert(fuzzyFalse < fuzzyTrue)
        XCTAssert(fuzzyFalse <= fuzzyTrue)
        XCTAssert(fuzzyFalse <= fuzzyFalse)
        XCTAssert(fuzzyTrue > fuzzyFalse)
        XCTAssert(fuzzyTrue >= fuzzyFalse)
        XCTAssert(fuzzyTrue >= fuzzyTrue)
    }
    
    func testNegation() {
        do {
            let fuzzy: Fuzzy = true
            XCTAssert(!fuzzy < fuzzy)
            XCTAssertEqual(fuzzy, !(!fuzzy))
        }

        do {
            let fuzzy: Fuzzy = false
            XCTAssert(!fuzzy > fuzzy)
            XCTAssertEqual(fuzzy, !(!fuzzy))
        }

        do {
            let fuzzy: Fuzzy = 0.4
            XCTAssert(!fuzzy > fuzzy)
            XCTAssertEqual(fuzzy, !(!fuzzy))
        }

        do {
            let fuzzy: Fuzzy = 0.6
            XCTAssert(!fuzzy < fuzzy)
            XCTAssertEqual(fuzzy, !(!fuzzy))
        }
    }

    func testConjunction() {
        do {
            let fuzzyA: Fuzzy = 0.3
            let fuzzyB: Fuzzy = true

            XCTAssert((fuzzyA && fuzzyB) <= fuzzyA)
            XCTAssert((fuzzyA && fuzzyB) <= fuzzyB)
        }

        do {
            let fuzzyA: Fuzzy = 0.3
            let fuzzyB: Fuzzy = false

            XCTAssert((fuzzyA && fuzzyB) <= fuzzyA)
            XCTAssert((fuzzyA && fuzzyB) <= fuzzyB)
        }

        do {
            let fuzzyA: Fuzzy = 0.7
            let fuzzyB: Fuzzy = true

            XCTAssert((fuzzyA && fuzzyB) <= fuzzyA)
            XCTAssert((fuzzyA && fuzzyB) <= fuzzyB)
        }

        do {
            let fuzzyA: Fuzzy = 0.7
            let fuzzyB: Fuzzy = false

            XCTAssert((fuzzyA && fuzzyB) <= fuzzyA)
            XCTAssert((fuzzyA && fuzzyB) <= fuzzyB)
        }
    }

    func testDisjunction() {
        do {
            let fuzzyA: Fuzzy = 0.3
            let fuzzyB: Fuzzy = true

            XCTAssert((fuzzyA || fuzzyB) >= fuzzyA)
            XCTAssert((fuzzyA || fuzzyB) >= fuzzyB)
        }

        do {
            let fuzzyA: Fuzzy = 0.3
            let fuzzyB: Fuzzy = false

            XCTAssert((fuzzyA || fuzzyB) >= fuzzyA)
            XCTAssert((fuzzyA || fuzzyB) >= fuzzyB)
        }
        
        do {
            let fuzzyA: Fuzzy = 0.7
            let fuzzyB: Fuzzy = true

            XCTAssert((fuzzyA || fuzzyB) >= fuzzyA)
            XCTAssert((fuzzyA || fuzzyB) >= fuzzyB)
        }
        
        do {
            let fuzzyA: Fuzzy = 0.7
            let fuzzyB: Fuzzy = false

            XCTAssert((fuzzyA || fuzzyB) >= fuzzyA)
            XCTAssert((fuzzyA || fuzzyB) >= fuzzyB)
        }
    }

}
