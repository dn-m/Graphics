#warning("Reinstate GraphicsTestCase (with non-OOP design) when harmony is achieved in swift test world")
//#if os(iOS) || os(watchOS) || os(tvOS) || os(OSX)
//
//import XCTest
//import Rendering
//import QuartzAdapter
//
//open class GraphicsTestCase: XCTestCase {
//
//    lazy var artifactsDirectory: URL = {
//        return Bundle(for: type(of: self)).bundleURL
//            .deletingLastPathComponent()
//            .appendingPathComponent("Artifacts")
//    }()
//
//    lazy var testCaseDirectory: URL = {
//        return self.artifactsDirectory.appendingPathComponent("\(type(of: self))")
//    }()
//
//    open override func setUp() {
//        super.setUp()
//        do {
//            try FileManager.default.createDirectory(
//                at: testCaseDirectory,
//                withIntermediateDirectories: true,
//                attributes: nil
//            )
//        } catch {
//            print(error)
//        }
//    }
//
//    open override func tearDown() {
//        super.tearDown()
//        let path = artifactsDirectory.absoluteString
//        _ = shell("open", path)
//    }
//
//    // TODO: Add Render `Composite` structures.
//    // TODO: Create new directory for current target / test case
//    public func render(_ layer: CALayer, name: String) {
//        layer.renderToPDF(at: testCaseDirectory.appendingPathComponent("\(name).pdf"))
//    }
//
//    public func render(_ path: RenderedPath, name: String) {
//        let layer = CAShapeLayer(path)
//        render(layer, name: name)
//    }
//
//    private func shell(_ args: String...) -> Int32 {
//        #if os(OSX)
//            let task = Process()
//            task.launchPath = "/usr/bin/env"
//            task.arguments = args
//            task.launch()
//            task.waitUntilExit()
//            return task.terminationStatus
//        #else
//            return 0
//        #endif
//    }
//
//    // Stub test to appease `swift test --generate-linuxmain`
//    func testExample() {
//
//    }
//}
//
//#endif
