//
//  Fuzzification.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 09/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

public struct Fuzzification {

    var fuzzification: [String: Fuzzy]

    public init() {
        fuzzification = [:]
    }

    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (String, Fuzzy) {
        fuzzification = Dictionary(minimumCapacity: sequence.underestimatedCount)

        for (name, fuzzy) in sequence {
            assert(!fuzzification.keys.contains(name),
                   "duplicate linguistic variable \(name)")

            fuzzification[name] = fuzzy
        }
    }

    public init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (LinguisticVariable, Fuzzy) {
        fuzzification = Dictionary(minimumCapacity: sequence.underestimatedCount)

        for (variable, fuzzy) in sequence {
            assert(!fuzzification.keys.contains(variable.name),
                   "duplicate linguistic variable \(variable.name)")

            fuzzification[variable.name] = fuzzy
        }
    }

    public subscript(index: String) -> Fuzzy {
        get {
            return fuzzification[index]!
        }
        set {
            fuzzification[index] = newValue
        }
    }

    public subscript(linguisticVariable: LinguisticVariable) -> Fuzzy {
        get {
            return fuzzification[linguisticVariable.name]!
        }
        set {
            fuzzification[linguisticVariable.name] = newValue
        }
    }

}
