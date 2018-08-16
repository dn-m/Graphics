//
//  GraphicsTesting.swift
//  GraphicsTesting
//
//  Created by James Bean on 8/15/18.
//

#if os(OSX)

import Foundation
import Rendering
import QuartzCore
import QuartzAdapter

let artifactsDirectory: URL = Bundle.main.bundleURL
    .deletingLastPathComponent()
    .appendingPathComponent("Artifacts")

func testCaseDirectory(for testName: String) -> URL {
    return artifactsDirectory.appendingPathComponent(testName)
}

func createArtifactsDirectory(for testName: String) throws {
    try FileManager.default.createDirectory(
        at: testCaseDirectory(for: testName),
        withIntermediateDirectories: true,
        attributes: nil
    )
}

func openArtifactsDirectory() {
    _ = shell("open", artifactsDirectory.absoluteString)
}

private func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

func render(_ layer: CALayer, testName: String, fileName: String) {
    layer.renderToPDF(at: testCaseDirectory(for: testName).appendingPathComponent("fileName"))
}

func render(_ path: RenderedPath, testName: String, fileName: String) {
    render(CAShapeLayer(path), testName: testName, fileName: fileName)
}

#endif

