//
//  Fuzzy.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 08/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

/// Fuzzy value.

public struct Fuzzy {

    let degreeOfMembership: Double

    init(_ degreeOfMembership: Double) {
        assert(degreeOfMembership >= 0 && degreeOfMembership <= 1,
               "degree of membership must fall into [0..1] range")

        self.degreeOfMembership = degreeOfMembership
    }

}