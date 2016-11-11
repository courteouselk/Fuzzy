//
//  Discourse.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 10/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

public struct Discourse {

    /// Discourse name.

    public let name: String

    /// Minimum for the values in the universe of `self`.

    public let min: Double

    /// Maximum for the values in the universe of `self`.

    public let max: Double

    /// Width of the universe of discourse.

    public var width: Double {
        return max - min
    }

    /// Creates a new discourse.
    ///
    /// - parameters:
    ///   - name: Discourse name.
    ///   - min: Minimum for the values in the universe of `self`.
    ///   - max: Maximum for the values in the universe of `self`.

    public init(name: String, min: Double = 0, max: Double = 1) {
        assert(max > min, "invalid discourse bounds, min == \(min), max == \(max)")

        self.name = name
        self.min = min
        self.max = max
    }

}
