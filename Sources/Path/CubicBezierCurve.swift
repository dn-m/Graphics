//
//  CubicBezierCurve.swift
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

/// - TODO: Move somewhere meaningful, perhaps in a `Constant` enum.
let tau: Double = 2 * .pi

/// - TODO: Move somewhere meaningful.
func cubeRoot(_ value: Double) -> Double {
    return value > 0 ? pow(value, 1/3) : -pow(-value, 1/3)
}

/// - Returns: The `t` values intersecting where the given `curve` intersects the given line.
///
/// - Author: Pomax
/// - See: http://jsbin.com/payifoxeho/edit?html,css,js
/// - Note: Cardano's algorithm, based on
/// http://www.trans4mind.com/personal_development/mathematics/polynomials/cubicAlgebra.htm.
///
///
/// - TODO: Use `Line` instead of `Line.Segment`.
///
func cardano(points: [Point], line: Line.Segment) -> Set<Double> {

    func align(points: [Point], with line: Line.Segment) -> [Point] {
        let a = -atan2(line.end.y - line.start.y, line.end.x - line.start.x)
        return points.map { point in
            Point(
                x: (point.x - line.start.x) * cos(a) - (point.y - line.start.y) * sin(a),
                y: (point.x - line.start.x) * sin(a) + (point.y - line.start.y) * cos(a)
            )
        }
    }

    let aligned = align(points: points, with: line)

    let pa = aligned[0].y
    let pb = aligned[1].y
    let pc = aligned[2].y
    let pd = aligned[3].y

    let d = (-pa + 3 * pb - 3 * pc + pd)
    let c = pa / d
    let b = (-3 * pa + 3 * pb) / d
    let a = (3 * pa - 6 * pb + 3 * pc) / d

    let p = (3 * b - a * a) / 3
    let p3 = p / 3
    let q = (2 * pow(a,3) - 9 * a * b + 27 * c) / 27
    let q2 = q / 2
    let discriminant = pow(q2, 2) + pow(p3, 3)

    if discriminant < 0 {
        let mp3 = -p / 3
        let mp33 = pow(mp3,3)
        let r = sqrt(mp33)
        let t = -q / (2 * r)
        let cosphi = t < -1 ? -1 : t > 1 ? 1 : t
        let phi = acos(cosphi)
        let t1 = 2 * cubeRoot(r)
        let x1 = t1 * cos(phi / 3) - a / 3
        let x2 = t1 * cos((phi + tau) / 3) - a / 3
        let x3 = t1 * cos((phi + 2 * tau) / 3) - a / 3
        return [x1, x2, x3]
    } else if discriminant == 0 {
        let u1 = q2 < 0 ? cubeRoot(-q2) : -cubeRoot(q2)
        let x1 = 2 * u1 - a / 3
        let x2 = -u1 - a / 3
        return [x1, x2]
    } else {
        let sd = sqrt(discriminant)
        let x1 = cubeRoot(-q2 + sd) - cubeRoot(q2 + sd) - a / 3
        return [x1]
    }
}

