//
//  SVG.Group.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

extension SVG {

    public struct Group {
        public let identifier: String
    }
}

extension SVG.Group: SVGInitializable {
    
    init(svgElement: SVGElement) throws {
        
        guard let identifier: String = svgElement.value(ofAttribute: "id") else {
            throw SVG.Parser.Error.illFormedGroup(svgElement)
        }
        
        self.init(identifier: identifier)
    }
}

#endif
