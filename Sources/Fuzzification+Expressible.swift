//
//  Fuzzification+Expressible.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 09/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension Fuzzification: ExpressibleByDictionaryLiteral {

    public init(dictionaryLiteral elements: (LinguisticVariable, Fuzzy)...) {
        self.init(elements)
    }

}
