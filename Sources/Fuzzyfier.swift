//
//  Fuzzyfier.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 03/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

open class Fuzzifier {

    // MARK: - Public API

    /// Discourse shared by all fuzzifier's linguistic variables.

    open var discourse: String {
        return ""
    }

    /// Return set names and their membership functions.
    ///
    /// Must be overriden (used in to initialize the fuzzifier).

    open var linguisticVariables: [LinguisticVariable] {
        return []
    }

    /// Fuzzifies crisp input into a group of fuzzy values each representing the degree of 
    /// membership of an input in the defined linguistic variables.
    ///
    /// - parameter crisp: An input value.

    public final func fuzzify(_ crisp: Double) -> Fuzzification {
        return Fuzzification(
            fuzzifiers.lazy.map { name, fuzzify in
                (name, fuzzify(crisp))
            }
        )
    }

    /// Creates a new fuzzifier instance.

    public init() {
        for linguisticVariable in linguisticVariables {
            assert(!fuzzifiers.keys.contains(linguisticVariable.name),
                   "duplicate linguistic variable name \(linguisticVariable.name)")

            fuzzifiers[linguisticVariable.name] = linguisticVariable.fuzzify
        }
    }

    // MARK: - Internal API

    typealias FuzzifyingFunction = (_ crsip: Double) -> Fuzzy

    internal private (set) var fuzzifiers: [String: FuzzifyingFunction] = [:]

}
