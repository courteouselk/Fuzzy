//
//  Fuzzification.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 09/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

/// Result of fuzzifying of some crisp value by a fuzzyfier.

public struct Fuzzification {

    var fuzzification: [String: Fuzzy]

    // MARK: - Public API

    /// Creates an empty fuzzyfication.

    public init() {
        fuzzification = [:]
    }

    /// Creates a new fuzzyfication with a sequence of `(String, Fuzzy)` tuples that reflect 
    /// linguistic variables and their respective fuzzy values.

    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (String, Fuzzy) {
        fuzzification = Dictionary(minimumCapacity: sequence.underestimatedCount)

        for (name, fuzzy) in sequence {
            assert(!fuzzification.keys.contains(name), "duplicate linguistic variable \(name)")

            fuzzification[name] = fuzzy
        }
    }

    /// Creates a new fuzzyfication with a sequence of `(LinguisticVariable, Fuzzy)` of linguistic
    /// variables and their respective fuzzy values.

    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (LinguisticVariable, Fuzzy) {
        fuzzification = Dictionary(minimumCapacity: sequence.underestimatedCount)

        for (variable, fuzzy) in sequence {
            assert(!fuzzification.keys.contains(variable.name), "duplicate linguistic variable \(variable.name)")

            fuzzification[variable.name] = fuzzy
        }
    }

    public subscript(name: String) -> Fuzzy {
        get {
            guard let fuzzy = fuzzification[name] else {
                fatalError("did not find the linguistic variable \(name)")
            }
            return fuzzy
        }
        set {
            fuzzification[name] = newValue
        }
    }

    public subscript(linguisticVariable: LinguisticVariable) -> Fuzzy {
        get {
            guard let fuzzy = fuzzification[linguisticVariable.name] else {
                fatalError("did not find the linguistic variable \(linguisticVariable.name)")
            }
            return fuzzy
        }
        set {
            fuzzification[linguisticVariable.name] = newValue
        }
    }

}
