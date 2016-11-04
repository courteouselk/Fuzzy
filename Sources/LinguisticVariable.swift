//
//  LinguisticVariable.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 04/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

public protocol LinguisticVariable {

    /// Fuzzy set membership function.
    ///
    /// - parameter crisp: An input (crisp) value.
    ///
    /// - important: Membership function must _always_ return a value within [0..1] range.
    ///
    /// - returns: Input value's degree of membership in linguistic variable's fuzzy set.

    typealias MembershipFunction = (_ crisp: Double) -> Double

    /// The name (typically adjective) that describes `self`.
    ///
    /// For example: "good", "fair", "high", "insufficient", etc.

    var name: String { get }

    /// A function that determines the degree of membership of a specific crisp value in the fuzzy
    /// set of `self`

    var membershipFunction: MembershipFunction { get }

}
