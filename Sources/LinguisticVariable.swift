//
//  LinguisticVariable.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 03/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

/// Basic (adjective) linguistic variable.

public struct LinguisticVariable {

    /// Membership function.
    ///
    /// Determines the degree of membership of an input crisp value in the fuzzy set that is
    /// represented by `self`.
    ///
    /// Membership function must _always_ return a value within [0..1] range.
    ///
    /// - parameter crisp: Input crisp value.

    public typealias MembershipFunction = (_ crisp: Double) -> Double

    /// A name (linguistic collocation) describing `self`.
    ///
    /// For example: "good", "fair", "very high", "not insufficient", etc.

    public let name: String

    /// Membership function.
    ///
    /// Determines the degree of membership for a specific crisp value in the fuzzy set 
    /// corresponding to `self`.
    ///
    /// - seealso: [Membership function](https://en.wikipedia.org/wiki/Membership_function_(mathematics))

    public func fuzzify(_ crisp: Double) -> Fuzzy {
        return Fuzzy(membershipFunction(crisp))
    }

    /// Creates a new linguistic variable using a free-style membership function.
    ///
    /// - parameters:
    ///   - name:     A name for the new linguistic vaiable (typically an adjective, e.g.
    ///               "adequate", "good", "generous", etc).
    ///   - function: Function (closure) that determines the degree of membership for a
    ///               specific input (crisp) value in the fuzzy set of `self`.  Must
    ///               _always_ return a value within the [0..1] range.

    public init(name: String, function: @escaping (_ crisp: Double) -> Double) {
        self.name = name
        membershipFunction = function
    }

    // MARK: - Internal API

    let membershipFunction: MembershipFunction

}
