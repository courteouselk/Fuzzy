# Fuzzy

A simple fuzzy logic framework.

## Example

### Fuzzifiers

````swift
import Fuzzy

public class Funding: Fuzzifier {

    private let _discourse = Discourse(name: "funding", min: 0, max: 100)

    public override var discourse: Discourse {
        return _discourse
    }

    public override var linguisticVariables: [LinguisticVariable] {
        return [Funding.inadequate, Funding.marginal, Funding.adequate]
    }

    public static let inadequate = LinguisticVariable(
        name: "inadequate",
        function: linearZ(slopeStart: 20, slopeEnd: 30)
    )

    public static let marginal = LinguisticVariable(
        name: "marginal",
        function: triangle(supportMin: 20, peak: 50, supportMax: 80)
    )

    public static let adequate = LinguisticVariable(
        name: "adequate",
        function: linearS(slopeStart: 60, slopeEnd: 80)
    )

}

public class Staffing: Fuzzifier {

    private let _discourse = Discourse(name: "staffing", min: 0, max: 100)

    public override var discourse: Discourse {
        return _discourse
    }

    public override var linguisticVariables: [LinguisticVariable] {
        return [Staffing.small, Staffing.large]
    }

    public static let small = LinguisticVariable(
        name: "small",
        function: Fuzzifier.linearZ(slopeStart: 30, slopeEnd: 58)
    )

    public static let large = LinguisticVariable(
        name: "large",
        function: Fuzzifier.linearS(slopeStart: 40, slopeEnd: 60)
    )

}

public class Risk: Fuzzifier {

    private let _discourse = Discourse(name: "risk", min: 0, max: 100)

    public override var discourse: Discourse {
        return _discourse
    }

    public override var linguisticVariables: [LinguisticVariable] {
        return [Risk.low, Risk.normal, Risk.high]
    }

    public static let low = LinguisticVariable(
        name: "low",
        function: linearZ(slopeStart: 20, slopeEnd: 40)
    )

    public static let normal = LinguisticVariable(
        name: "normal",
        function: triangle(supportMin: 20, peak: 50, supportMax: 80)
    )

    public static let high = LinguisticVariable(
        name: "high",
        function: linearS(slopeStart: 60, slopeEnd: 80)
    )

}
````

### Inferer

````swift
struct RiskInferer {

    let fundingFuzzifier = Funding()
    let staffingFuzzifier = Staffing()
    let riskFuzzifier = Risk()

    func infer(funding crispFunding: Double, staffing crispStaffing: Double) -> Double {
        let funding = fundingFuzzifier.fuzzify(crispFunding)

        let staffing = staffingFuzzifier.fuzzify(crispStaffing)

        let risk: Fuzzification = [
            Risk.low    : funding[Funding.adequate] || staffing[Staffing.small],
            Risk.normal : funding[Funding.marginal] && staffing[Staffing.large],
            Risk.high   : funding[Funding.inadequate]
        ]

        return riskFuzzifier.defuzzify(risk, aggregationSlices: 10)
    }

}
````

### Usage

````swift
let riskInferer = RiskInferer()

let risk = riskInferer.infer(funding: 35, staffing: 70)
````
