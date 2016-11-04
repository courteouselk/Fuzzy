//
//  Fuzzyfier.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 03/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

open class Fuzzifier {

    /// Fuzzifier's domain.

    open var domain: String {
        return ""
    }

    /// Return set names and their membership functions.
    ///
    /// Must be overriden (used in to initialize the fuzzifier).

    open var linguisticVariables: [LinguisticVariable] {
        return []
    }

    private var membershipFunctions: [String: LinguisticVariable.MembershipFunction] = [:]

    /// Creates a new fuzzifier instance.

    public init() {
        linguisticVariables.forEach { v in
            assert(!membershipFunctions.keys.contains(v.name), "duplicate linguistic variable name \(v.name)")
            membershipFunctions[v.name] = v.membershipFunction
        }
    }

    /// Fuzzifies a given crisp input into a dictionary of linguistic variable names and their 
    /// corresponding degrees of membership.
    ///
    /// - parameter crisp: An input value.

    final public func fuzzify(_ crisp: Double) -> [String: Double] {
        return membershipFunctions.map { degreeOfMembership in
            let result = degreeOfMembership(crisp)
            assert(result >= 0 && result <= 1, "membership function output must be always be in [0..1] interval")
            return result
        }
    }

}
