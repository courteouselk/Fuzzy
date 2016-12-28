//
//  Fuzzy.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 08/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

/// Fuzzy value.

public struct Fuzzy : Equatable, Comparable, Hashable, CustomReflectable, CustomStringConvertible {

    public static let `false` = Fuzzy(0)
    public static let `true` = Fuzzy(1)

    let degreeOfMembership: Double

    init(_ degreeOfMembership: Double) {
        assert(degreeOfMembership >= 0 && degreeOfMembership <= 1, "degree of membership must fall into [0..1] range")

        self.degreeOfMembership = degreeOfMembership
    }

    // MARK: - Equatable

    public static func == (lhs: Fuzzy, rhs: Fuzzy) -> Bool {
        return lhs.degreeOfMembership == rhs.degreeOfMembership
    }

    // MARK: - Comparable

    public static func < (lhs: Fuzzy, rhs: Fuzzy) -> Bool {
        return lhs.degreeOfMembership < rhs.degreeOfMembership
    }

    public static func > (lhs: Fuzzy, rhs: Fuzzy) -> Bool {
        return lhs.degreeOfMembership > rhs.degreeOfMembership
    }

    public static func <= (lhs: Fuzzy, rhs: Fuzzy) -> Bool {
        return lhs.degreeOfMembership <= rhs.degreeOfMembership
    }

    public static func >= (lhs: Fuzzy, rhs: Fuzzy) -> Bool {
        return lhs.degreeOfMembership >= rhs.degreeOfMembership
    }

    // MARK: - Hashable

    public var hashValue: Int {
        return degreeOfMembership.hashValue
    }

    // MARK: - CustomReflectable

    public var customMirror: Mirror {
        return Mirror(reflecting: degreeOfMembership)
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        return degreeOfMembership.description
    }


}
