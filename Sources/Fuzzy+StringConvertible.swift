//
//  Fuzzy+StringConvertible.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 09/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension Fuzzy: CustomStringConvertible {

    public var description: String {
        return degreeOfMembership.description
    }

}
