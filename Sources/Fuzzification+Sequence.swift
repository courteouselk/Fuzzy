//
//  Fuzzification+Sequence.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 11/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension Fuzzification : Sequence {

    public func makeIterator() -> AnyIterator<(key: String, value: Fuzzy)> {
        return AnyIterator(fuzzification.makeIterator())
    }

}
