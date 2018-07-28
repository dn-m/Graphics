//
//  ConvexPolygon.swift
//  Path
//
//  Created by James Bean on 6/6/17.
//
//

/// Concrete ConvexPolygon.
public struct ConvexPolygon: ConvexPolygonProtocol {

    // MARK: - Instance Properties

    /// Vertices contained herein.
    public let vertices: VertexCollection

    // MARK: - Initializers

    /// Creates a `ConvexPolygon` with the given sequence of `vertices.
    ///
    /// - Warning: Will crash if the given `vertices` form a concave polygon!
    public init <S: Sequence> (vertices: S) where S.Iterator.Element == Point {

        let vertices = VertexCollection(vertices)

        guard vertices.formConvexPolygon else {
            fatalError("Cannot create a ConvexPolygon with a concave vertex collection")
        }

        self.vertices = vertices
    }
}
