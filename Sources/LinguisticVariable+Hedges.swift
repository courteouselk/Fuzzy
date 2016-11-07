//
//  LinguisticVariable+Hedges.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 04/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

public extension LinguisticVariable {

    /// A modifier (hedge) that can be applied to the existing lingustic variable.

    public enum Hedge: String {
        case not = "not"
        case very = "very"
    }

    /// Creates a new linguistic variable using a hedge applied on the existing one.
    ///
    /// - parameters:
    ///   - hedge: A hedge to be applied.
    ///   - base: An underlying (base) linguistic variable to be modified with a hedge.

    public init(hedge: Hedge, base: LinguisticVariable) {
        let modifiedName = "\(hedge.rawValue) \(base.name)"

        switch hedge {
        case .not:
            self.init(name: modifiedName) { crisp in
                return (1 - base.membershipFunction(crisp))
            }

        case .very:
            self.init(name: modifiedName) { crisp in
                let baseResult = base.membershipFunction(crisp)
                return baseResult * baseResult
            }
        }
    }

}
