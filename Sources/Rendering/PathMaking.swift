//
//  PathMaking.swift
//  StaffClef
//
//  Created by James Bean on 6/13/16.
//
//

import QuartzCore

/**
 For graphical objects that need to generate a path.
 */
public protocol PathMaking {
    
    // MARK: - Instance Properties
    
    /// Path of the object.
    var path: CGPath? { get set }
    
    // MARK: - Instance Methods
    
    /// Generate the path.
    func makePath() -> CGPath
}
