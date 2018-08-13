//
//  Point+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import Geometry

extension Point {
    
    // In the form: "x,y"
    init?(string: String) {
        self.init(stringValues: string.components(separatedBy: ","))
    }
    
    init?(stringValues: [String]) {
        self.init(values: stringValues.compactMap { Double($0) })
    }
    
    init?(values: [Double]) {
        
        guard values.count == 2 else {
            return nil
        }
        
        self.init(x: values[0], y: values[1])
    }
}

#endif
