//
//  Fuzzy.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 08/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

/// Fuzzy value.

public struct Fuzzy : Equatable, Comparable, Hashable {

    /// Complete falsehood.

    public static let `false` = Fuzzy(crisp: false)

    /// Complete truth.

    public static let `true` = Fuzzy(crisp: true)

    let truthyness: Double

    /// Creates a new fuzzy value.
    ///
    /// - parameters:
    ///   - truthyness: Indicates the degree of truthyness for new fuzzy value, with 0.0 being a 
    ///                 complete falsehood and 1.0 being a complete truth.

    public init(truthyness: Double) {
        precondition(truthyness >= 0.0 && truthyness <= 1.0,
                     "truthyness must fall within the range of [0..1]")

        self.truthyness = truthyness
    }

    /// Creates a new fuzzy value.
    ///
    /// - parameters:
    ///   - crisp: Crisp `true` or crisp `false` for the new fuzzy value.

    public init(crisp: Bool) {
        truthyness = crisp ? 1.0 : 0.0
    }

    /// Creates a new fuzzy value.
    ///
    /// `truthynessScore` equal to 0 will create a fuzzy value with complete falsehood measure, 
    /// while `truthynessScore` equal to `competeTruthScore` will produce a complete truth.
    ///
    /// - parameters:
    ///   - truthynessScore:  Non-negative integer indicating the degree of the truthyness for new
    ///                       fuzzy value.
    ///   - competeTruthScore:  Positive integer marking the complete truth score.

    public init(truthynessScore: Int, competeTruthScore: Int) {
        precondition(competeTruthScore > 0, "competeTruthScore must be positive integer")
        precondition(truthynessScore >= 0 && truthynessScore <= competeTruthScore, "competeTruthScore must be positive integer")

        self.init(truthyness: Double(truthynessScore) / Double(competeTruthScore))
    }

    // MARK: - Equatable

    public static func == (lhs: Fuzzy, rhs: Fuzzy) -> Bool {
        return lhs.truthyness == rhs.truthyness
    }

    // MARK: - Comparable

    public static func < (lhs: Fuzzy, rhs: Fuzzy) -> Bool {
        return lhs.truthyness < rhs.truthyness
    }

    public static func > (lhs: Fuzzy, rhs: Fuzzy) -> Bool {
        return lhs.truthyness > rhs.truthyness
    }

    public static func <= (lhs: Fuzzy, rhs: Fuzzy) -> Bool {
        return lhs.truthyness <= rhs.truthyness
    }

    public static func >= (lhs: Fuzzy, rhs: Fuzzy) -> Bool {
        return lhs.truthyness >= rhs.truthyness
    }

    // MARK: - Hashable

    public var hashValue: Int {
        return truthyness.hashValue
    }

}

// MARK: - CustomReflectable

extension Fuzzy : CustomReflectable {

    public var customMirror: Mirror {
        return Mirror(reflecting: truthyness)
    }

}

// MARK: - CustomStringConvertible

extension Fuzzy : CustomStringConvertible {

    public var description: String {
        return truthyness.description
    }

}

// MARK: - ExpressibleByBooleanLiteral

extension Fuzzy : ExpressibleByBooleanLiteral {

    public init(booleanLiteral isTrue: BooleanLiteralType) {
        self.init(crisp: isTrue)
    }

}

// MARK: - ExpressibleByFloatLiteral

extension Fuzzy : ExpressibleByFloatLiteral {

    public init(floatLiteral value: FloatLiteralType) {
        self.init(truthyness: value)
    }
    
}
