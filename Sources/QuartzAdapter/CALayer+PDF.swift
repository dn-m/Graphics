//
//  CALayer+PDF.swift
//  Rendering
//
//  Created by James Bean on 6/2/17.
//
//

#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)

import QuartzCore
import Rendering

extension CALayer {

    public func renderToPDF(at location: URL) {

        let margin: CGFloat = 20
        var pageFrame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width + 2 * margin,
            height: bounds.height + 2 * margin
        )

        let context = CGContext(location as CFURL, mediaBox: &pageFrame, nil)!
        context.beginPDFPage(nil)

        // flip coordinates
        context.translateBy(x: 0, y: pageFrame.height)
        context.scaleBy(x: 1, y: -1)

        context.translateBy(x: margin, y: margin)
        render(in: context)
        context.endPDFPage()
    }
}

#endif

