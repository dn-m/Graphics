//
//  Text+CATextLayer.swift
//  Rendering
//
//  Created by James Bean on 6/13/17.
//
//

import Rendering

#if os(iOS)
    import UIKit
    let scale = UIScreen.main.scale
#elseif os(OSX)
    import AppKit
    let scale = NSScreen.main!.backingScaleFactor
#endif

//extension CATextLayer {
//    
//    public convenience init(_ text: Text) {
//        self.init()
//        frame = CGRect(text.frame)
//        string = text.value
//        font = text.font
//        fontSize = CGFloat(text.fontSize)
//        foregroundColor = text.color.cgColor
//        contentsScale = scale
//    }
//}
