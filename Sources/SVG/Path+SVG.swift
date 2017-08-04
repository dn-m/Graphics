//
//  Path+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

import Foundation
import Restructure
import Geometry
import Path
// TODO: Use PatternMatching
import Structure

extension Path: SVGInitializable {
    
    init(svgElement: SVGElement) throws {
        
        switch svgElement.name {
            
        // Parse path data for lines, quad curves, and cubic curves.
        case "path":
            self = try polybezier(svgElement: svgElement)
            
        // Parse default shape types
        case SVG.shapesByName.keys:
            self = try shape(svgElement: svgElement)
            
        // Non-path data!
        default:
            throw SVG.Parser.Error.illFormedPath(svgElement)
        }
    }
}

private func shape(svgElement: SVGElement) throws -> Path {
    
    guard let shape = SVG.shapesByName[svgElement.name] else {
        throw SVG.Parser.Error.illFormedPath(svgElement)
    }
    
    return try shape.init(svgElement: svgElement).path
}

private func polybezier(svgElement: SVGElement) throws -> Path {
    
    guard let pathData: String = svgElement.value(ofAttribute: "d") else {
        throw SVG.Parser.Error.illFormedPath(svgElement)
    }
    
    let commands = commandStrings(from: pathData)
    
    let pathElements: [PathElement] = commands.reduce([]) { accum, cur in
        
        let (command, values) = cur
        let prev = accum.last
        
        let pathElement = PathElement(
            svgCommand: command,
            svgValues: values,
            previous: prev
        )
        
        return accum + pathElement
    }
    
    return Path(pathElements: pathElements)
}

private let svgCommands = CharacterSet(charactersIn: "MmLlVvHhQqTtCcSsZz")

private func commandStrings(from pathString: String) -> [(String, String)] {

    var commands: [String] = []
    var values: [String] = []
    var commandStart: Int?

    for (s,scalar) in pathString.unicodeScalars.enumerated() {
        switch scalar {
        case svgCommands:
            commands.append(String(scalar))
            if let commandStart = commandStart {
                // FIXME: Add tests!
                let start = pathString.index(pathString.startIndex, offsetBy: commandStart)
                let end = pathString.index(pathString.startIndex, offsetBy: s)
                values.append(String(pathString[start ..< end]))
            }
            commandStart = s + 1
        default:
            break
        }
    }

    return zip(commands, values).map { $0 }
}

/// - Returns: `true` if the given `array` contains the given `value`.
private func ~= <S> (set: S, value: S.Element) -> Bool where S: SetAlgebra {
    return set.contains(value)
}
