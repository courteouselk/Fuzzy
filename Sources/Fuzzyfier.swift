//
//  Fuzzyfier.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 03/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

open class Fuzzifier {

    // MARK: - Internal API

    typealias FuzzifyingFunction = (_ crsip: Double) -> Fuzzy

    internal private (set) var fuzzifiers: [String: FuzzifyingFunction] = [:]

    // MARK: - Public API

    /// Discourse shared by all fuzzifier's linguistic variables.

    open var discourse: Discourse {
        return Discourse(name: "")
    }

    /// Return set names and their membership functions.
    ///
    /// Must be overriden (used in to initialize the fuzzifier).

    open var linguisticVariables: [LinguisticVariable] {
        return []
    }

    /// Creates a new fuzzifier instance.

    public init() {
        for linguisticVariable in linguisticVariables {
            assert(!fuzzifiers.keys.contains(linguisticVariable.name), "duplicate linguistic variable name \(linguisticVariable.name)")

            fuzzifiers[linguisticVariable.name] = linguisticVariable.fuzzify
        }
    }

    /// Fuzzifies crisp input into a group of fuzzy values each representing the degree of
    /// membership of an input in the defined linguistic variables.
    ///
    /// - parameter crisp: An input value.

    public final func fuzzify(_ crisp: Double) -> Fuzzification {
        assert(crisp >= discourse.min && crisp <= discourse.max, "crisp value is outside of universe of discourse")

        return Fuzzification(
            fuzzifiers.lazy.map { name, fuzzify in
                (name, fuzzify(crisp))
            }
        )
    }

    /// Defuzzifies an input fuzzy values set with linguistic variable membership degrees into a 
    /// crisp value.
    ///
    /// - parameters 
    ///   - fuzzification: Input fuzzy values for the consequent's linguistic variables.
    ///   - aggregationSlices: The count of slices to use for the centroid technique of 
    ///                        defuzzification.

    public final func defuzzify(_ fuzzification: Fuzzification, aggregationSlices: Int = 100) -> Double {
        assert(aggregationSlices >= 10 && aggregationSlices <= 10000, "invalid aggregation slices count \(aggregationSlices)")

        let range = stride(from: discourse.min, through: discourse.max, by: discourse.width / Double(aggregationSlices))

        let aggregation: [(x: Double, degreeOfMembership: Double)] = range.map { x in
            let clippedConsequentRuleOutputs: [Fuzzy] = fuzzification.map { linguisticVariableName, fuzzy in
                let consequentRuleOutput = fuzzifiers[linguisticVariableName]!(x)
                let clippedConsequentRuleOutput = consequentRuleOutput && fuzzy
                return clippedConsequentRuleOutput
            }

            let aggregatedRulesOutput = clippedConsequentRuleOutputs.reduce(Fuzzy.false, ||)

            return (x, aggregatedRulesOutput.truthyness)
        }

        let fraction = aggregation.reduce((numerator: 0.0, denominator: 0.0)) {
            let numerator = $0.numerator + $1.x * $1.degreeOfMembership
            let denominator = $0.denominator + $1.degreeOfMembership

            return (numerator, denominator)
        }

        return fraction.numerator / fraction.denominator
    }
    
}
