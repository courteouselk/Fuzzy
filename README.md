# Fuzzy

A simple fuzzy logic framework.

## Example

Let's take as an example the inferer described in chapter 4.6.1 "Mamdani-style inference" from the book 
["Artificial Intelligence"](https://www.google.nl/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwiIg6_CoKbQAhUMlxoKHQG-ArwQFggdMAA&url=http%3A%2F%2Fwww.academia.dk%2FBiologiskAntropologi%2FEpidemiologi%2FDataMining%2FArtificial_Intelligence-A_Guide_to_Intelligent_Systems.pdf)
by Michael Negnevitsky.

### Fuzzifiers

First we need some basic bricks, called fuzzifiers.  We need both, those that fuzzify crisp inputs 
into the fuzzy values (to be fed to the inference rules), and those that defuzzify inferred 
fuzzy result(s) into the crisp output.

````swift
import Fuzzy

public class Funding: Fuzzifier {

    // Discourse gives some idea about what does this fuzzifier represent, and indicates its 
    // valid values range. 

    private let _discourse = Discourse(name: "funding", min: 0, max: 100)
    public override var discourse: Discourse { return _discourse }

    // Linguistic variables describe how each particular crisp value maps onto fuzzy sets described
    // in the human language.

    public override var linguisticVariables: [LinguisticVariable] {
        return [Funding.inadequate, Funding.marginal, Funding.adequate]
    }

    // Here go individual linguistic variable definitions

    public static let inadequate = LinguisticVariable(
        name: "inadequate",
        function: linearZ(slopeStart: 15, slopeEnd: 35)
    )

    public static let marginal = LinguisticVariable(
        name: "marginal",
        function: triangle(supportMin: 21, peak: 41, supportMax: 61)
    )

    public static let adequate = LinguisticVariable(
        name: "adequate",
        function: linearS(slopeStart: 55, slopeEnd: 75)
    )

}
````

The rest of fuzzifiers are defined similarly.

````swift
public class Staffing: Fuzzifier {

    private let _discourse = Discourse(name: "staffing", min: 0, max: 100)
    public override var discourse: Discourse { return _discourse }

    public override var linguisticVariables: [LinguisticVariable] {
        return [Staffing.small, Staffing.large]
    }

    public static let small = LinguisticVariable(
        name: "small",
        function: linearZ(slopeStart: 29, slopeEnd: 69)
    )

    public static let large = LinguisticVariable(
        name: "large",
        function: linearS(slopeStart: 37, slopeEnd: 77)
    )
    
}

public class Risk: Fuzzifier {

    private let _discourse = Discourse(name: "risk", min: 0, max: 100)
    public override var discourse: Discourse { return _discourse }

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

Second thing to do is to declare an inferer that glues fuzzifiers together.

````swift
public struct RiskInferer {

    private let fundingFuzzifier = Funding()
    private let staffingFuzzifier = Staffing()
    private let riskFuzzifier = Risk()

    public func infer(funding crispFunding: Double, staffing crispStaffing: Double) -> Double {

        // Fuzzify crisp inputs

        let funding = fundingFuzzifier.fuzzify(crispFunding)
        let staffing = staffingFuzzifier.fuzzify(crispStaffing)

        // Here come the fuzzy inference rules

        let risk: Fuzzification = [
            Risk.low    : funding[Funding.adequate] || staffing[Staffing.small], // You can use 
            Risk.normal : funding[Funding.marginal] && staffing[Staffing.large], // traditional 
            Risk.high   : funding[Funding.inadequate]                            // logical operators
        ]

        // Defuzzify inferred result into crisp output

        return riskFuzzifier.defuzzify(risk, aggregationSlices: 10)
    }

}
````

### Usage

And that's it!  You can use it now.

````swift
let riskInferer = RiskInferer()

let risk = riskInferer.infer(funding: 35, staffing: 70) // ~ 67.42
````
