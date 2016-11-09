//
//  Fuzzyfier+MembershipFunctions.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 04/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

public extension Fuzzifier {

    /// _Singleton_ membership function.
    ///
    /// - parameter support: X position of the singleton's `1` value.

    public static func singleton(at position: Double) -> LinguisticVariable.MembershipFunction {
        return { crisp in
            return crisp == position ? 1 : 0
        }
    }

    /// _Triangle_ membership function.
    ///
    /// - parameters:
    ///   - supportMin: X position of the left support verticle of the triangle.
    ///   - peak: X corresponding to the peak verticle.
    ///   - supportMax: X at the right suppport verticle.

    public static func triangle(supportMin: Double, peak: Double, supportMax: Double) -> LinguisticVariable.MembershipFunction {
        assert(supportMin < peak && peak < supportMax,
               "malformed triangle: supportMin == \(supportMin), peak == \(peak), supportMax == \(supportMax)")

        let leftSideBaseWidth = peak - supportMin
        let rightSideBaseWidth = supportMax - peak

        return { crisp in
            if crisp <= supportMin { return 0 }
            if crisp == peak { return 1 }
            if crisp >= supportMax { return 0 }

            if crisp < peak {
                return (crisp - supportMin) / leftSideBaseWidth
            } else {
                return (supportMax - crisp) / rightSideBaseWidth
            }
        }
    }

    /// _Linear-Z_ membership function.
    ///
    /// - parameters:
    ///   - slopeStart: X position at the start of the slope.
    ///   - slopeEnd: X at the end of the slope.

    public static func linearZ(slopeStart: Double, slopeEnd: Double) -> LinguisticVariable.MembershipFunction {
        assert(slopeStart < slopeEnd, "malformed linear Z: slopeStart == \(slopeStart), slopeEnd == \(slopeEnd)")

        let slopeWidth = slopeEnd - slopeStart

        return { crisp in
            if crisp <= slopeStart { return 1 }
            if crisp >= slopeEnd { return 0 }

            return (slopeEnd - crisp) / slopeWidth
        }
    }

    /// _Linear-S_ membership function.
    ///
    /// - parameters:
    ///   - slopeStart: X position at the start of the slope.
    ///   - slopeEnd: X at the end of the slope.

    public static func linearS(slopeStart: Double, slopeEnd: Double) -> LinguisticVariable.MembershipFunction {
        assert(slopeStart < slopeEnd, "malformed linear S: slopeStart == \(slopeStart), slopeEnd == \(slopeEnd)")

        let slopeWidth = slopeEnd - slopeStart

        return { crisp in
            if crisp <= slopeStart { return 0 }
            if crisp >= slopeEnd { return 1 }

            return (crisp - slopeStart) / slopeWidth
        }
    }

}
