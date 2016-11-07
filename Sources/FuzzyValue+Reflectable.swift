//
//  FuzzyValue+Reflectable.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 07/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension FuzzyVaue: CustomReflectable {

    public var customMirror: Mirror {
        let labeledChildren: DictionaryLiteral<String, Any> = [
            "domain": domain,
            "degreesOfMembership": degreesOfMembership
        ]

        return Mirror(self, children: labeledChildren, displayStyle: .tuple)
    }
    
}
