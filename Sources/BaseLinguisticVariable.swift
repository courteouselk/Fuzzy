//
//  BaseLinguisticVariable.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 03/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

/// Basic (adjective) linguistic variable.

public struct BaseLinguisticVariable: LinguisticVariable {

    public let name: String
    public let membershipFunction: LinguisticVariable.MembershipFunction

    public init(name: String, membershipFunction: @escaping LinguisticVariable.MembershipFunction) {
        self.name = name
        self.membershipFunction = membershipFunction
    }

}
