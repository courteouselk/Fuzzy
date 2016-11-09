//
//  Fuzzy+Reflectable.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 08/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension Fuzzy: CustomReflectable {

    public var customMirror: Mirror {
        return Mirror(reflecting: degreeOfMembership)
    }

}
