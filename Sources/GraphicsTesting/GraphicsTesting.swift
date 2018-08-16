//
//  GraphicsTesting.swift
//  GraphicsTesting
//
//  Created by James Bean on 8/15/18.
//

#if os(OSX)
import QuartzCore
import QuartzAdapter
#endif

import Foundation
import Rendering

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

func render(_ composite: Composite, testName: String, fileName: String) {
    #if os(OSX)
    let layer = CALayer(composite)
    layer.renderToPDF(at: testCaseDirectory(for: testName).appendingPathComponent("fileName"))
    #else
    print("We are not on macOS, so we are not going to generate graphics test artifacts.")
    #endif
}
