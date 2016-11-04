//
//  HedgeLinguisticVariable.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 04/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

public struct HedgeLinguisticVariable: LinguisticVariable {

    public let name: String
    public let membershipFunction: LinguisticVariable.MembershipFunction

    public enum Hedge: String {
        case very = "very"
    }

    public init(hedge: Hedge, base: LinguisticVariable) {
        name = "\(hedge.rawValue) \(base.name)"

        switch hedge {
        case .very:
            membershipFunction = { crisp in
                let baseSet = base.membershipFunction(crisp)
                return baseSet * baseSet
            }
        }
    }

}
