//
//  TextBox.swift
//  Rendering
//
//  Created by James Bean on 6/13/17.
//
//

import Geometry

public struct TextBox {
    
    public let text: Text
    public let borderColor: Color
    public let borderWidth: Double
    public let backgroundColor: Color
    public let insets: Insets
    public let frame: Rectangle
    
    public init(
        text: String,
        font: String,
        textColor: Color,
        borderWidth: Double,
        borderColor: Color,
        backgroundColor: Color,
        origin: Point = Point(),
        height: Double = 50,
        insets: Insets = .zero
    )
    {
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.insets = insets
        
        self.text = Text(text,
            font: font,
            height: height - (insets.top + insets.bottom),
            color: textColor
        )

        self.frame = Rectangle(
            origin: origin,
            size: Size(
                width: self.text.width + (insets.left + insets.right),
                height: height
            )
        )
    }
}

