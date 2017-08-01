//
//  RenderedPath.swift
//  Rendering
//
//  Created by James Bean on 6/18/17.
//
//

import Geometry
import Path

public struct RenderedPath {
    
    public let frame: Rectangle
    public let path: Path
    public let styling: Styling
    
    public init(
        frame: Rectangle = .zero,
        path: Path = .zero,
        styling: Styling = Styling()
    )
    {
        self.frame = frame
        self.path = path
        self.styling = styling
    }
}

extension RenderedPath {

    public var resizedToFitContents: RenderedPath {

        // Get the bounding box of the path in local coordinate space
        let bbox = self.path.axisAlignedBoundingBox

        // Normalized the path so that it is a tight fit with the new frame
        let path = self.path.translated(by: -bbox.origin)

        // Adjust the position within parent coordinate space to compensate for change in path
        let frame = bbox.translated(by: self.frame.origin)

        return RenderedPath(
            frame: frame,
            path: path,
            styling: styling
        )
    }

    public func translated(by point: Point) -> RenderedPath {
        return RenderedPath(frame: frame.translated(by: point), path: path, styling: styling)
    }

    public func scaled(by value: Double) -> RenderedPath {

        let fill = styling.fill
        let stroke = styling.stroke

        let newStroke = Stroke(
            width: stroke.width * value,
            color: stroke.color,
            join: stroke.join,
            cap: stroke.cap,
            dashes: stroke.dashes
        )

        let newStyle = Styling(fill: fill, stroke: newStroke)

        return RenderedPath(frame: frame, path: path.scaled(by: value), styling: newStyle)
    }
}

extension RenderedPath: CustomStringConvertible {

    public var description: String {
        var result = "RenderedPath:\n"
        result += "Frame: \(frame)\n"
        result += "\(path)\n"
        result += "\(styling)"
        return result
    }
}
