//
//  FuzzyValue.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 06/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

/// Fuzzy value.

public struct FuzzyVaue {

    /// Domain of the `self`.
    ///
    /// Assigned from the fuzzifier's domain.

    public let domain: String

    /// A dicionary with all linguistic variables and their corresponding degrees of membership
    /// values.

    public let degreesOfMembership: [String: Double]

    init(domain: String, degreesOfMembership: [String: Double]) {
        self.domain = domain
        self.degreesOfMembership = degreesOfMembership
    }

    init<F: Fuzzifier>(fuzzifier: F, degreesOfMembership: [String: Double]) {
        self.init(domain: fuzzifier.domain, degreesOfMembership: degreesOfMembership)
    }

}


