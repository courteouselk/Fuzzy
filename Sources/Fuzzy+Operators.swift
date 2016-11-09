//
//  Fuzzy+Operators.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 09/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension Fuzzy {

    public static func && (lhs: Fuzzy, rhs: Fuzzy) -> Fuzzy {
        return Fuzzy(min(lhs.degreeOfMembership, rhs.degreeOfMembership))
    }

    public static func || (lhs: Fuzzy, rhs: Fuzzy) -> Fuzzy {
        return Fuzzy(max(lhs.degreeOfMembership, rhs.degreeOfMembership))
    }

}
