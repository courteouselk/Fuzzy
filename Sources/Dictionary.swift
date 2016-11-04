//
//  Dictionary.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 03/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

extension Dictionary {

    /// Maps `self` to another dictionary with the same keys, and values converted by `transform`
    /// function.
    ///
    /// - parameter transform: A converting function.

    func map<T>(_ transform: (Value) throws -> T) rethrows -> [Key: T] {
        var output = [Key: T](minimumCapacity: count)

        for (key, value) in self {
            output[key] = try transform(value)
        }

        return output
    }
    
}
