//
//  LayoutNodeTests.swift
//  Rendering
//
//  Created by James Bean on 1/16/17.
//
//

import XCTest
import DataStructures
@testable import Rendering

class LayoutNodeTests: XCTestCase {

    func testInit() {
        let _ = LayoutNode()
    }
    
    func testNodeTypeOperations() {
        let node = LayoutNode()
        XCTAssert(node.isRoot)
        XCTAssert(node.isLeaf)
        node.addChild(LayoutNode())
    }
    
    func testFrameAtInit() {
        let layer = CALayer()
        let frame = CGRect(
            origin: CGPoint(x: 100, y: 100),
            size: CGSize(width: 100, height: 100)
        )
        layer.frame = frame
        let node = LayoutNode(layer)
        XCTAssertEqual(node.frame, frame)
    }
    
    func testMutateFrameMutatesLayer() {
        let node = LayoutNode()
        let frame = CGRect(
            origin: CGPoint(x: 100, y: 100),
            size: CGSize(width: 100, height: 100)
        )
        node.frame = frame
        XCTAssertEqual(node.layer.frame, frame)
    }
    
    func testHierarchyAddChild() {
        let parent = LayoutNode()
        let child = LayoutNode()
        parent.addChild(child)
        XCTAssert(child.parent === parent)
    }
    
    func testHierarchyInsertChild() {
        let parent = LayoutNode()
        let child = LayoutNode()
        do {
            try parent.insertChild(child, at: 0)
            XCTAssert(child.parent === parent)
        } catch { XCTFail() }
    }
    
    // MARK: - Test Stack
    
    func testStackVerticallyFromTopNoPadding() {
        let amountChildren = 3
        let childHeight = 10
        let root = LayoutNode(stackingVerticallyFrom: .top, aligningHorizontallyTo: .none)
        
        (0..<amountChildren).forEach { _ in
            let layer = CALayer()
            layer.frame = CGRect(
                origin: CGPoint.zero,
                size: CGSize(width: 0, height: childHeight)
            )
            let child = LayoutNode(layer)
            root.addChild(child)
        }
        
        root.layout()
        XCTAssertEqual(root.frame.height, 30)
        
        // Ensure order
    }
    
    func testStackVerticallyFromTopWithPadBottom() {
        let amountChildren = 3
        let childHeight = 10
        let padding: CGFloat = 5
        let root = LayoutNode(stackingVerticallyFrom: .top, aligningHorizontallyTo: .none)
        
        (0..<amountChildren).forEach { _ in
            let layer = CALayer()
            layer.frame = CGRect(
                origin: CGPoint.zero,
                size: CGSize(width: 0, height: childHeight)
            )
            let child = LayoutNode(layer)
            child.padding.bottom = padding
            root.addChild(child)
        }
        
        root.layout()
        XCTAssertEqual(root.frame.height, 40)
        
        // Ensure order
    }
    
    func testVerticallyFromTopWithTopAndBottomPadding() {
        let amountChildren = 3
        let childHeight = 10
        let padTop: CGFloat = 5
        let padBottom: CGFloat = 1
        let root = LayoutNode(stackingVerticallyFrom: .top, aligningHorizontallyTo: .none)
        
        (0..<amountChildren).forEach { _ in
            let layer = CALayer()
            layer.frame = CGRect(
                origin: .zero,
                size: CGSize(width: 0, height: childHeight)
            )
            let child = LayoutNode(layer)
            child.padding.top = padTop
            child.padding.bottom = padBottom
            root.addChild(child)
        }
        
        root.layout()
        XCTAssertEqual(root.frame.height, 42)
    }
    
    
    func testStackVerticallyFromBottomNoPad() {
        let amountChildren = 3
        let childHeight = 10
        let root = LayoutNode(stackingVerticallyFrom: .bottom, aligningHorizontallyTo: .none)
        
        (0..<amountChildren).forEach { _ in
            let layer = CALayer()
            layer.frame = CGRect(
                origin: CGPoint.zero,
                size: CGSize(width: 0, height: childHeight)
            )
            let child = LayoutNode(layer)
            root.addChild(child)
        }
        
        root.layout()
        XCTAssertEqual(root.frame.height, 30)
    }
    
    func testStackVerticallyFromBottomPadTop() {
        let amountChildren = 3
        let childHeight = 10
        let padding: CGFloat = 5
        let root = LayoutNode(stackingVerticallyFrom: .bottom, aligningHorizontallyTo: .none)
        
        (0..<amountChildren).forEach { _ in
            let layer = CALayer()
            layer.frame = CGRect(
                origin: CGPoint.zero,
                size: CGSize(width: 0, height: childHeight)
            )
            let child = LayoutNode(layer)
            child.padding.top = padding
            root.addChild(child)
        }
        
        root.layout()
        XCTAssertEqual(root.frame.height, 40)
    }
    
    func testStackHorizontallyFromLeftNoPad() {
        let amountChildren = 3
        let childWidth = 10
        let root = LayoutNode(stackingHorizontallyFrom: .left, aligningVerticallyTo: .none)
        
        (0..<amountChildren).forEach { _ in
            let layer = CALayer()
            layer.frame = CGRect(
                origin: CGPoint.zero,
                size: CGSize(width: childWidth, height: 0)
            )
            let child = LayoutNode(layer)
            root.addChild(child)
        }
        
        root.layout()
        XCTAssertEqual(root.frame.width, 30)
    }
    
    func testStackHorizontallyFromLeftWithPad() {
        let amountChildren = 3
        let childWidth = 10
        let padding: CGFloat = 5
        let root = LayoutNode(stackingHorizontallyFrom: .left, aligningVerticallyTo: .none)
        
        (0..<amountChildren).forEach { _ in
            let layer = CALayer()
            layer.frame = CGRect(
                origin: CGPoint.zero,
                size: CGSize(width: childWidth, height: 0)
            )
            let child = LayoutNode(layer)
            child.padding.right = padding
            root.addChild(child)
        }
        
        root.layout()
        XCTAssertEqual(root.frame.width, 40)
    }
    
    // MARK: - Test Flow
    
    // MARK: - Test setWidthWithChildren
    
    func testSetWidthWithChildren() {
        let childHeight = 10
        let childWidth = 40
        let amountChildren = 3
        let padding: CGFloat = 5
        let root = LayoutNode(stackingVerticallyFrom: .bottom, aligningHorizontallyTo: .none)
        
        (0..<amountChildren).forEach { _ in
            let layer = CALayer()
            layer.frame = CGRect(
                origin: CGPoint.zero,
                size: CGSize(width: childWidth, height: childHeight)
            )
            let child = LayoutNode(layer)
            child.padding.top = padding
            root.addChild(child)
        }
        
        root.layout()
        XCTAssertEqual(root.frame.width, 40)
    }
    
    // MARK: - Text setHeightWithChildren
    
    // MARK: - Test inserting nodes
    
    func testInsertChild() {
        let root = LayoutNode()
        let child1 = LayoutNode()
        let child2 = LayoutNode()
        let child3 = LayoutNode()
        root.addChild(child1)
        root.addChild(child3)
        do {
            try root.insertChild(child2, at: 1)
            XCTAssertEqual(root.children.index(of: child2), 1)
        } catch { XCTFail() }
    }
    
    func testInsertChildAtIndexEmptyThrows() {
        let root = LayoutNode()
        let child = LayoutNode()
        do {
            try root.insertChild(child, at: 1)
            XCTFail()
        } catch { /* success */ }
    }
    
    func testInsertChildAfterNonexistentNode() {
        let root = LayoutNode()
        let uncontainedNode = LayoutNode()
        let child = LayoutNode()
        do {
            try root.insertChild(child, after: uncontainedNode)
            XCTFail()
        } catch { /* success */ }
    }
    
    func testInsertChildAtEndIndexSucceeds() {
        let root = LayoutNode()
        (0..<3).forEach { _ in root.addChild(LayoutNode()) }
        // endIndex = 3
        do {
            try root.insertChild(LayoutNode(), at: 3)
        } catch { XCTFail() }
    }
    
    
    func testInsertChildAfterAtEnd() {
        let root = LayoutNode()
        let child1 = LayoutNode()
        let child2 = LayoutNode()
        root.addChild(child1)
        do {
            try root.insertChild(child2, after: child1)
        } catch { XCTFail() }
    }
    
    func testInsertChildBeforeNodeSucceeds() {
        let root = LayoutNode()
        let child1 = LayoutNode()
        let child2 = LayoutNode()
        let child3 = LayoutNode()
        root.addChild(child1)
        root.addChild(child3)
        do {
            try root.insertChild(child2, before: child3)
            XCTAssertEqual(root.children.index(of: child2), 1)
        } catch { XCTFail() }
    }
    
    func testInsertChildBeforeFirstChildSucceeds() {
        let root = LayoutNode()
        let child1 = LayoutNode()
        let child2 = LayoutNode()
        let child3 = LayoutNode()
        root.addChild(child2)
        root.addChild(child3)
        do {
            try root.insertChild(child1, before: child2)
            XCTAssertEqual(root.children.index(of: child1), 0)
        } catch { XCTFail() }
    }
    
    // MARK: - Test removing nodes
    
    func testRemoveChildAtIndexEmptyThrows() {
        let root = LayoutNode()
        do {
            try root.removeChild(LayoutNode())
            XCTFail()
        } catch { /* success */ }
    }
    
    func testRemoveChildAtIndexOutOfBoundsThrows() {
        let root = LayoutNode()
        (0..<3).forEach { _ in root.addChild(LayoutNode()) }
        do {
            try root.removeChild(at: 4)
            XCTFail()
        } catch { /* success */ }
    }
    
    func testRemoveChildAtIndexSucceeds() {
        let root = LayoutNode()
        (0..<3).forEach { _ in root.addChild(LayoutNode()) }
        do {
            try root.removeChild(at: 1)
        } catch { XCTFail() }
    }
    
    func testRemoveChildNotChildThrows() {
        let root = LayoutNode()
        let uncontainedNode = LayoutNode()
        do {
            try root.removeChild(uncontainedNode)
            XCTFail()
        } catch { /* success */ }
    }
    
    func testRemoveChildSucceeds() {
        let root = LayoutNode()
        let child = LayoutNode()
        root.addChild(child)
        do {
            try root.removeChild(child)
            XCTAssertNil(child.layer.superlayer)
        } catch { XCTFail() }
    }
    
    // MARK: - Nested LayoutNode tests
    
    func testNestedLayoutNodeFrames() {
        let root = LayoutNode(stackingVerticallyFrom: .top, aligningHorizontallyTo: .none)
        let child = LayoutNode(stackingVerticallyFrom: .top, aligningHorizontallyTo: .none)
        
        let grandchildHeight = 10
        (0..<3).forEach { _ in
            let layer = CALayer()
            layer.frame = CGRect(
                origin: CGPoint.zero,
                size: CGSize(width: 0, height: grandchildHeight)
            )
            let grandchild = LayoutNode(layer)
            child.addChild(grandchild)
            child.layout()
        }
        root.addChild(child)
        root.layout()
        XCTAssertEqual(root.frame.height, 30)
    }
}
