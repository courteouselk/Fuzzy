//
//  Fuzzy+Expressible.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 08/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension Fuzzy: ExpressibleByBooleanLiteral {

    public init(booleanLiteral isTrue: BooleanLiteralType) {
        self = isTrue ? Fuzzy(1) : Fuzzy(0)
    }

}

extension Fuzzy: ExpressibleByFloatLiteral {

    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)
    }

}
