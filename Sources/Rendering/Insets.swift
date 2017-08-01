//
//  Insets.swift
//  Rendering
//
//  Created by James Bean on 6/13/17.
//
//

public struct Insets {
    
    public static let zero = Insets(top: 0, left: 0, bottom: 0, right: 0)
    
    public let top: Double
    public let left: Double
    public let bottom: Double
    public let right: Double
    
    public init(top: Double = 0, left: Double = 0, bottom: Double = 0, right: Double = 0) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
    
    public init(vertical: Double, horizontal: Double) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    public init(_ value: Double) {
        self.init(vertical: value, horizontal: value)
    }
}
