//
//  Fuzzy+Expressible.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 08/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

// MARK: ExpressibleByBooleanLiteral

extension Fuzzy : ExpressibleByBooleanLiteral {

    public init(booleanLiteral isTrue: BooleanLiteralType) {
        self = isTrue ? Fuzzy.true : Fuzzy.false
    }

}

// MARK: - ExpressibleByFloatLiteral

extension Fuzzy : ExpressibleByFloatLiteral {

    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)
    }

}
