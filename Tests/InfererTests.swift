//
//  InfererTests.swift
//  FuzzyTests
//
//  Created by Anton Bronnikov on 13/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

import XCTest
import Fuzzy

class InfererTests: XCTestCase {

    func testInference() {
        let riskInferer = RiskInferer()

        let risk = riskInferer.infer(funding: 25, staffing: 65)

        XCTAssert(abs(risk - 67.419354839) < 0.000000001)
    }

}

// MARK: - Infrastructure

extension InfererTests {

    // MARK: Funding fuzzifier

    public class Funding: Fuzzifier {

        private let _discourse = Discourse(name: "funding", min: 0, max: 100)

        public override var discourse: Discourse {
            return _discourse
        }

        public override var linguisticVariables: [LinguisticVariable] {
            return [Funding.inadequate, Funding.marginal, Funding.adequate]
        }

        public static let inadequate = LinguisticVariable(
            name: "inadequate",
            function: linearZ(slopeStart: 15, slopeEnd: 35)
        )

        public static let marginal = LinguisticVariable(
            name: "marginal",
            function: triangle(supportMin: 21, peak: 41, supportMax: 61)
        )

        public static let adequate = LinguisticVariable(
            name: "adequate",
            function: linearS(slopeStart: 55, slopeEnd: 75)
        )
        
    }

    // MARK: Staffing fuzzifier

    public class Staffing: Fuzzifier {

        private let _discourse = Discourse(name: "staffing", min: 0, max: 100)

        public override var discourse: Discourse {
            return _discourse
        }

        public override var linguisticVariables: [LinguisticVariable] {
            return [Staffing.small, Staffing.large]
        }

        public static let small = LinguisticVariable(
            name: "small",
            function: linearZ(slopeStart: 29, slopeEnd: 69)
        )

        public static let large = LinguisticVariable(
            name: "large",
            function: linearS(slopeStart: 37, slopeEnd: 77)
        )
        
    }

    // MARK: Risk fuzzifier

    public class Risk: Fuzzifier {

        private let _discourse = Discourse(name: "risk", min: 0, max: 100)

        public override var discourse: Discourse {
            return _discourse
        }

        public override var linguisticVariables: [LinguisticVariable] {
            return [Risk.low, Risk.normal, Risk.high]
        }

        public static let low = LinguisticVariable(
            name: "low",
            function: linearZ(slopeStart: 20, slopeEnd: 40)
        )

        public static let normal = LinguisticVariable(
            name: "normal",
            function: triangle(supportMin: 20, peak: 50, supportMax: 80)
        )

        public static let high = LinguisticVariable(
            name: "high",
            function: linearS(slopeStart: 60, slopeEnd: 80)
        )
        
    }

    // MARK: Risk inferer

    public struct RiskInferer {

        private let fundingFuzzifier = Funding()
        private let staffingFuzzifier = Staffing()
        private let riskFuzzifier = Risk()

        public func infer(funding crispFunding: Double, staffing crispStaffing: Double) -> Double {
            // Fuzzify crisp inputs

            let funding = fundingFuzzifier.fuzzify(crispFunding)
            let staffing = staffingFuzzifier.fuzzify(crispStaffing)

            // Here come the fuzzy inference rules
            let risk: Fuzzification = [
                Risk.low    : funding[Funding.adequate] || staffing[Staffing.small],
                Risk.normal : funding[Funding.marginal] && staffing[Staffing.large],
                Risk.high   : funding[Funding.inadequate]
            ]

            // Defuzzify inferred result into crisp output
            return riskFuzzifier.defuzzify(risk, aggregationSlices: 10)
        }
        
    }

}
