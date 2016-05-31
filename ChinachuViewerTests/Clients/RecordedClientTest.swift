//
//  ProgramTest.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/27.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation
import XCTest
import OHHTTPStubs
@testable import ChinachuViewer

class RecordedClientTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.


        guard let path = NSBundle(forClass: RecordedClientTests.self).pathForResource("RecordedClientTest", ofType: "json") else {
            XCTFail("Can't read the json file for test")
            return
        }
        self.data = NSData(contentsOfFile: path)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        print(self.data)
        XCTAssert(true)
    }

    func testRecordedEntity() {
        let expectation = expectationWithDescription("download recorded.json and parse it")
        stub(isHost(Constants.apiHost)) { request in
            let path = OHPathForFileInBundle("RecordedClientTest.json", NSBundle(forClass: RecordedClientTests.self))!
            return OHHTTPStubsResponse(fileAtPath: path, statusCode: 200, headers: ["Content-Type": "application/json"])
        }
        RecordedClient.fetchRecordedList { (result) in
            switch result {
            case .Success:
                guard let recordedList = result.value else {
                    XCTFail()
                    return
                }
                XCTAssert(recordedList.count == 1)
                let recorded = recordedList[0]
                XCTAssert(recorded.program.id          == "bs151-ess")
                XCTAssert(recorded.program.channelId   == "BS_151")
                XCTAssert(recorded.program.channelName == "ＢＳ朝日１")


                expectation.fulfill()
            case .Failure:
                // TODO なんかエラー表示する
                XCTFail()
            }
        }
        waitForExpectationsWithTimeout(3) { error in
            XCTFail()
        }
    }
}
