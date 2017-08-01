//
//  PathRepresentable.swift
//  PathTools
//
//  Created by James Bean on 6/17/17.
//
//

/// Interface for types that can produce a `Path` representation of themselves.
public protocol PathRepresentable {
    
    /// `Path` representation.
    var path: Path { get }
}
