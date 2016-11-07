//
//  LinguisticVariable+Operators.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 05/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension LinguisticVariable {

    static prefix func !(rhs: LinguisticVariable) -> LinguisticVariable {
        return LinguisticVariable(hedge: .not, base: rhs)
    }

}
