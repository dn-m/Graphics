//
//  CollectionWrapping.swift
//  Path
//
//  Created by Benjamin Wetherfield on 6/29/19.
//

/// `CollectionWrapping` is a type-erasing protocol that allows a `Collection`-conforming
/// structure to wrap any underlying `Collection` implementation.
///
/// As a result, all of the `Collection` boilerplate is done for free.
public protocol CollectionWrapping: Collection {
    
    // MARK: - Associated Types
    
    /// Wrapped `Collection`-conforming type.
    associatedtype Base: Collection
    
    // MARK: - Instance Properties
    
    /// Wrapped `Collection`-conforming type.
    var base: Base { get }
}

extension CollectionWrapping {
    
    // MARK: - Collection
    
    /// Start index.
    public var startIndex: Base.Index {
        return base.startIndex
    }
    
    /// End index.
    public var endIndex: Base.Index {
        return base.endIndex
    }
    
    /// Index after given index `i`.
    public func index(after i: Base.Index) -> Base.Index {
        return base.index(after: i)
    }
    
    /// - returns: Element at the given `index`.
    public subscript (index: Base.Index) -> Base.Element {
        return base[index]
    }
}
