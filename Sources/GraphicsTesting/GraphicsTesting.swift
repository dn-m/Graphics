//
//  GraphicsTesting.swift
//  GraphicsTesting
//
//  Created by James Bean on 8/15/18.
//

#if os(OSX)

import Foundation
import QuartzCore
import QuartzAdapter
import Rendering

/// The URL of the directory where the graphics test artifacts of all tests will be generated.
public let artifactsDirectory: URL = Bundle.main.bundleURL
    .deletingLastPathComponent()
    .appendingPathComponent("Artifacts")

/// The URL of the directory where the graphics test artifacts for the given `testName` will be
/// generated.
public func testCaseDirectory(for testCaseName: String) -> URL {
    return artifactsDirectory.appendingPathComponent(testCaseName)
}

/// - Returns: The URL for the given `fileName` in the directory for the given `testCaseName`.
public func location(forFile fileName: String, in testCaseName: String) -> URL {
    return testCaseDirectory(for: testCaseName).appendingPathComponent(fileName)
}

/// Creates the directory where the graphics test artifacts for the given `testName` will be
/// generated.
public func createArtifactsDirectory(for testName: String) {
    do {
        try FileManager.default.createDirectory(
            at: testCaseDirectory(for: testName),
            withIntermediateDirectories: true,
            attributes: nil
        )
    } catch {
        print(error)
    }
}

/// Opens the artifacts directory in the finder for easy visual perusing.
public func openArtifactsDirectory() {
    _ = shell("open", artifactsDirectory.absoluteString)
}

/// Render the given `StyledPath.Composite` to PDF in the direction for the test case with the given
/// `testCaseName`, with the given `fileName`.
public func render(
    _ composite: StyledPath.Composite,
    fileName: String,
    testCaseName: String
) {
    do {
        try composite.renderToPDF(at: location(forFile: fileName + ".pdf", in: testCaseName))
    } catch {
        print(error)
    }
}

/// Runs the given bash `args`.
private func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

#endif
