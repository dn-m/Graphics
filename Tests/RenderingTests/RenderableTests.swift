//
//  RenderableTests.swift
//  Rendering
//
//  Created by James Bean on 6/27/17.
//
//

import XCTest
import Rendering

class RenderableTests: XCTestCase {
    
    struct RModel { }
    struct RConfiguration { }
    
    struct R: Renderable {
        
        var rendered: Composite {
            fatalError()
        }
        
        let configuration: RConfiguration
        let model: RModel
        
        init(model: RModel, configuration: RConfiguration) {
            self.model = model
            self.configuration = configuration
        }
    }
}
