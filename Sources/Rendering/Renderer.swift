//
//  Renderer.swift
//  Rendering
//
//  Created by James Bean on 1/10/17.
//
//

/// Renders its information onto the given `layer` with a given `configuration`.
public protocol Renderer {
    
    associatedtype Configuration
    associatedtype GraphicalContext
    
    /// Render contents in a given `context`, with a given `configuration`.
    func render(in context: GraphicalContext, with configuration: Configuration)
}
