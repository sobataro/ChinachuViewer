//
//  ProgramTest.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/27.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation
import XCTest
@testable import ChinachuViewer

class ProgramTests: XCTestCase {
    var jsonData: NSData? = nil

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        guard let path = NSBundle(forClass: ProgramTests.self).pathForResource("ProgramTest", ofType: "json") else {
            XCTFail("Can't read the json file for test")
            return
        }
        self.jsonData = NSData(contentsOfFile: path)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        print(jsonData)
        XCTAssert(true)
    }
}
