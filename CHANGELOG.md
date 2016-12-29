# Change Log

## Unreleased

### API changes

- `Fuzzy` adopts `Equatable`, `Comparable`, `Hashable`.
- `Fuzzy` has public constructors `init(_: Double)` and `init(numerator: Int, denominator: Int)`

### Other

- Added basic unit-tests for `Fuzzy` type

## [0.0.1](https://github.com/courteouselk/Fuzzy/releases/tag/0.0.1)

- Fuzzifier base class
- Three base functions for linguistic variables (linear Z, S, and triangle)
- Min/max based fuzzy logic operators `&&` and `||`
- The concept of hedge modifiers for existing linguistic variables
- Centroid method for defuzzification
