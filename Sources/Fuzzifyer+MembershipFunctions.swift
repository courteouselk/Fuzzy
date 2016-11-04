//
//  Fuzzifyer+MembershipFunctions.swift
//  Fuzzy
//
//  Created by Anton Bronnikov on 04/11/2016.
//  Copyright © 2016 Anton Bronnikov. All rights reserved.
//

public extension Fuzzifier {

    /// _Singleton_ membership function.
    ///
    /// - parameter support: X position of the singleton's `1` value.

    public static func singleton(support: Double) -> LinguisticVariable.MembershipFunction {
        return { crisp in
            if crisp == support { return 1 }
            return 0
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
    ///   - slopeMin: X position at the start of the slope.
    ///   - slopeMax: X at the end of the slope.

    public static func linearZ(slopeMin: Double, slopeMax: Double) -> LinguisticVariable.MembershipFunction {
        assert(slopeMin < slopeMax, "malformed linear Z: slopeMin == \(slopeMin), slopeMax == \(slopeMax)")

        let slopeWidth = slopeMax - slopeMin

        return { crisp in
            if crisp <= slopeMin { return 1 }
            if crisp >= slopeMax { return 0 }

            return (slopeMax - crisp) / slopeWidth
        }
    }

    /// _Linear-S_ membership function.
    ///
    /// - parameters:
    ///   - slopeMin: X position at the start of the slope.
    ///   - slopeMax: X at the end of the slope.

    public static func linearS(slopeMin: Double, slopeMax: Double) -> LinguisticVariable.MembershipFunction {
        assert(slopeMin < slopeMax, "malformed linear S: slopeMin == \(slopeMin), slopeMax == \(slopeMax)")

        let slopeWidth = slopeMax - slopeMin

        return { crisp in
            if crisp <= slopeMin { return 0 }
            if crisp >= slopeMax { return 1 }

            return (crisp - slopeMin) / slopeWidth
        }
    }

}
