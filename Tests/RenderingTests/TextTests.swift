//
//  TextTests.swift
//  Rendering
//
//  Created by James Bean on 6/13/17.
//
//

import XCTest
import QuartzCore
import Rendering


// FIXME: Reintroduce
// import GraphicsTestTools

// class TextTests: GraphicsTestCase {
//
//    func testGetFontWithCapSize() {
//        
//        let font = CGFont("Helvetica" as CFString)!
//        
//        // Determine destination height, constrained for numbers / capital letters
//        let height: Double = 50
//        let emPoints = height / Double(font.capHeight)
//        let fontSize = 2048 * emPoints
//        
//        // 2048 - (capHeight - descent)
//        //let deltaY = CGFloat(2048 - (font.capHeight - font.descent)) * CGFloat(emPoints)
//        
//        let capHeightPoints = Double(font.capHeight) * emPoints
//        let ascentPoints = Double(font.ascent) * emPoints
//        let descentPoints = Double(font.descent) * emPoints
//        let xHeightPoints = Double(font.xHeight) * emPoints
//        print("capHeight: \(capHeightPoints)")
//        print("ascent: \(ascentPoints)")
//        print("descent: \(descentPoints)")
//        print("xHeight: \(xHeightPoints)")
//        
//        //let deltaY = descentPoints//fontSize - Double(capHeightPoints)
//        let deltaY = descentPoints
//        print("font size: \(fontSize)")
//        print("deltaY: \(deltaY)")
//        
//        let textLayer = CATextLayer()
//        textLayer.font = font
//        textLayer.fontSize = CGFloat(fontSize)
//        textLayer.string = "109 K.iii"
//        textLayer.foregroundColor = UIColor.green.cgColor
//        textLayer.contentsScale = UIScreen.main.scale
//        textLayer.frame = CGRect(x: 0, y: CGFloat(deltaY), width: 200, height: CGFloat(fontSize))
//        textLayer.alignmentMode = kCAAlignmentLeft
//        textLayer.borderColor = UIColor.red.cgColor
//        textLayer.borderWidth = 1
//
//        let layer = CALayer()
//        layer.frame = CGRect(x: 0, y: 0, width: 200, height: height)
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 1
//        layer.addSublayer(textLayer)
//        layer.renderToPDF(name: "textByHeight")
//    }
//    
//    func DISABLED_testTextConstrainedForNumbersAndUpperCase() {
//
//        #if os(iOS)
//            func printFonts() {
//                let fontFamilyNames = UIFont.familyNames
//                for familyName in fontFamilyNames {
//                    
//                    //print("Font Family Name = [\(familyName)]")
//                    let names = UIFont.fontNames(forFamilyName: familyName)
//                    //print("Font Names: \(names)")
//                    
//                    for name in names {
//                        print("------------------------------")
//                        print(name)
//                        let height: Double = 50
//                        let fontName = name
//                        let text = Text("109", font: fontName, height: height)
//                        print("text.em: \(text.em)")
//                        XCTAssertEqualWithAccuracy(text.capHeight, height, accuracy: 0.0000001)
//                        
//                        let layer = CATextLayer(text)
//                        print("layer.frame: \(layer.frame)")
//                        
//                        let container = CALayer()
//                        container.addSublayer(layer)
//                        container.frame = CGRect(x: 0, y: 0, width: 200, height: height)
//                        container.borderWidth = 1
//                        container.borderColor = Color.blue.cgColor
//                        render(container, name: "testByHeight_109_\(fontName)")
//                    }
//                }
//            }
//            
//            
//            printFonts()
//            
//        #endif
//
//    }
// }
