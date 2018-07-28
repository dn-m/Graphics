//
//  PolygonError.swift
//  Path
//
//  Created by James Bean on 6/7/17.
//
//

/// Things that can go wrong when creating a `PolygonProtocol`-conforming type.
public enum PolygonError: Error {

    /// Invalid vertices, attempted shape type, message.
    case invalidVertices(VertexCollection, PolygonProtocol.Type, String)
}
