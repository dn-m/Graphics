//
//  PathElement+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

import DataStructures
import Geometry
import Path

enum Coordinates {
    case absolute
    case relative
}

extension PathElement {
    
    public init?(svgCommand: String, svgValues: String, previous: PathElement?) {
        
        func pathElement(
            using builder: PathElementBuilder,
            in coordinates: Coordinates
        ) -> PathElement
        {
            return builder(values(from: svgValues), coordinates, previous)
        }
        
        switch svgCommand {
        case "Z", "z":
            self = .close
        case builderAndCoordinatesByCommand.keys:
            let (builder, coordinates) = builderAndCoordinatesByCommand[svgCommand]!
            self = pathElement(using: builder, in: coordinates)
        default:
            return nil
        }
    }
}

private typealias PathElementBuilder = ([Double], Coordinates, PathElement?) -> PathElement

private let builderAndCoordinatesByCommand: [String: (PathElementBuilder, Coordinates)] = [
    "M": (move, .absolute),
    "m": (move, .relative),
    "L": (line, .absolute),
    "l": (line, .relative),
    "V": (vertical, .absolute),
    "v": (vertical, .relative),
    "H": (horizontal, .absolute),
    "h": (horizontal, .relative),
    "Q": (quadraticBroken, .absolute),
    "q": (quadraticBroken, .relative),
    "T": (quadraticSmooth, .absolute),
    "t": (quadraticSmooth, .relative),
    "C": (cubicBroken, .absolute),
    "c": (cubicBroken, .relative),
    "S": (cubicSmooth, .absolute),
    "s": (cubicSmooth, .relative),
    "Z": (close, .absolute),
    "z": (close, .relative)
]

// MARK: - Command builders

private func move(values: [Double], coordinates: Coordinates, previous: PathElement?)
    -> PathElement
{
    let ref = coordinates == .relative ? previous?.point ?? Point() : Point()
    return .move(Point(x: values[0], y: values[1]) + ref)
}

private func line(values: [Double], coordinates: Coordinates, previous: PathElement?)
    -> PathElement
{
    let ref = coordinates == .relative ? previous?.point ?? Point() : Point()
    return .line(Point(x: values[0], y: values[1]) + ref)
}

private func vertical(values: [Double], coordinates: Coordinates, previous: PathElement?)
    -> PathElement
{
    let prev = previous?.point ?? Point()
    let ref = coordinates == .relative ? prev : Point()
    return .line(Point(x: prev.x, y: values[0] + ref.y))
}

private func horizontal(values: [Double], coordinates: Coordinates, previous: PathElement?)
    -> PathElement
{
    let prev = previous?.point ?? Point()
    let ref = coordinates == .relative ? prev : Point()
    return .line(Point(x: values[0] + ref.x, y: prev.y))
}

private func cubicSmooth(values: [Double], in coordinates: Coordinates, previous: PathElement?)
    -> PathElement
{
    return cubic(values: values, in: coordinates, smooth: true, previous: previous)
}

private func cubicBroken(values: [Double], in coordinates: Coordinates, previous: PathElement?)
    -> PathElement
{
    return cubic(values: values, in: coordinates, smooth: false, previous: previous)
}

private func cubic(
    values: [Double],
    in coordinates: Coordinates,
    smooth: Bool = false,
    previous: PathElement?
) -> PathElement
{
 
    let ref = referencePoint(in: coordinates, from: previous)
    let control1: Point
    let control2: Point
    let destination: Point
    
    if smooth {
        control1 = smoothControlPoint(for: previous!)!
        control2 = Point(x: values[0], y: values[1]) + ref
        destination = Point(x: values[2], y: values[3]) + ref
    } else {
        control1 = Point(x: values[0], y: values[1]) + ref
        control2 = Point(x: values[2], y: values[3]) + ref
        destination = Point(x: values[4], y: values[5]) + ref
    }

    return .curve(destination, control1, control2)
}

private func quadraticSmooth(
    values: [Double],
    in coordinates: Coordinates,
    previous: PathElement?
) -> PathElement
{
    return quadratic(values: values, in: coordinates, smooth: true, previous: previous)
}

private func quadraticBroken(
    values: [Double],
    in coordinates: Coordinates,
    previous: PathElement?
) -> PathElement
{
    return quadratic(values: values, in: coordinates, smooth: false, previous: previous)
}

func quadratic(
    values: [Double],
    in coordinates: Coordinates,
    smooth: Bool = false,
    previous: PathElement?
) -> PathElement
{
    let ref = referencePoint(in: coordinates, from: previous)
    let control: Point
    let destination: Point

    if smooth {
        control = smoothControlPoint(for: previous!)!
        destination = Point(x: values[0], y: values[1]) + ref
    } else {
        control = Point(x: values[0], y: values[1]) + ref
        destination = Point(x: values[2], y: values[3]) + ref
    }
    
    return .quadCurve(destination, control)
}

func close(values: [Double], in coordinates: Coordinates, previous: PathElement?)
    -> PathElement
{
    return .close
}

// MARK: - Helpers

func referencePoint(in coordinates: Coordinates, from previous: PathElement?) -> Point {
    return coordinates == .relative ? previous?.point ?? Point() : Point()
}

func smoothControlPoint(for pathElement: PathElement) -> Point? {
    
    func pointReflected(from control: Point, over end: Point) -> Point {
        let segment = Line.Segment(start: control, end: end)
        let ray = Line.Ray(segment)
        return ray.point(at: segment.length * 2)
    }
    
    switch pathElement {
    case let .quadCurve(end, control):
        return pointReflected(from: control, over: end)
    case let .curve(end, _, control2):
        return pointReflected(from: control2, over: end)
    default:
        return nil
    }
}

