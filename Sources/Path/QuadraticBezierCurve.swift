//
//  QuadraticBezierCurve.swift
//  Path
//
//  Created by James Bean on 8/16/18.
//

#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

import Geometry

/// - Returns: A `Set` of 0, 1, or 2 x-intercepts for the given coefficients.
///
/// - TODO: Update in dn-m/Math
func quadratic(_ a: Double, _ b: Double, _ c: Double) -> Set<Double> {

    print("quadratic: \(a), \(b), \(c)")
    let discriminant = pow(b,2) - (4 * a * c)

    guard discriminant >= 0 else {
        return Set()
    }

    let val0 = (-b + sqrt(discriminant)) / (2 * a)
    let val1 = (-b - sqrt(discriminant)) / (2 * a)

    print("val0: \(val0), val1: \(val1)")

    var result: Set<Double> = []

    // This differs from the more generic version. Find a way to do this cleansing after?
    if val0 <= 1 {
        result.insert(val0)
    }

    if (0...1).contains(val1) {
        result.insert(val1)
    }

    return result
}
