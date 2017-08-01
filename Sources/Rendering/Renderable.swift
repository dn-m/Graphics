//
//  Renderable.swift
//  Rendering
//
//  Created by James Bean on 6/27/17.
//
//

/// Type which can be configured by its own `Configuration` type.
public protocol Renderable {
    
    /// `Composite`-representation of `Renderable`-conforming type.
    var rendered: Composite { get }
}
