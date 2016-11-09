//
//  Fuzzification+Reflectable.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 09/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension Fuzzification: CustomReflectable {

    public var customMirror: Mirror {
        return Mirror(reflecting: fuzzification)
    }

}
