//
//  Fuzzy+Operators.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 09/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension Fuzzy {

    public static prefix func ! (rhs: Fuzzy) -> Fuzzy {
        return Fuzzy(truthyness: 1 - rhs.truthyness)
    }

    public static func && (lhs: Fuzzy, rhs: Fuzzy) -> Fuzzy {
        return Fuzzy(truthyness: min(lhs.truthyness, rhs.truthyness))
    }

    public static func || (lhs: Fuzzy, rhs: Fuzzy) -> Fuzzy {
        return Fuzzy(truthyness: max(lhs.truthyness, rhs.truthyness))
    }

}
