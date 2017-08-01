//
//  ConvexPolygonContainer.swift
//  Path
//
//  Created by James Bean on 6/6/17.
//
//

/// Contains one or more `ConvexPolygonProtocol`-conforming types, for the purposes of
/// collision detection.
public struct ConvexPolygonContainer {

    // MARK: - Instance Properties

    /// `ConvexPolygonProtocol`-conforming types contained herein.
    public let polygons: [ConvexPolygonProtocol]

    // MARK: - Initializers

    /// Creates a `ConvexPolygonContainer` with the given `polygons`.
    public init <S: Sequence> (_ polygons: S) where S.Iterator.Element: ConvexPolygonProtocol {
        self.polygons = Array(polygons)
    }

    /// Creates a `ConvexPolygonContainer` with the single `convexPolygon`.
    public init(_ convexPolygon: ConvexPolygonProtocol) {
        self.polygons = [convexPolygon]
    }
}
