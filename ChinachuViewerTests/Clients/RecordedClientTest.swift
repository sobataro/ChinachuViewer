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
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
                XCTAssert(recorded.tuner    == "PT3-S2")
                XCTAssert(recorded.command  == "recpt1 --device /dev/pt3video1 --b25 --strip --sid 151 151 - -")
                XCTAssert(recorded.filePath == "/tank/record/[151219-1854][BS151][PT3-S2]地球紀行　「BBCスペシャル フランスの大自然 動物たちの物語」.m2ts")

                let program = recorded.program
                XCTAssert(program.id          == "bs151-ess")
                XCTAssert(program.channelId   == "BS_151")
                XCTAssert(program.channelName == "ＢＳ朝日１")
                XCTAssert(program.category    == "etc")
                XCTAssert(program.title       == "地球紀行　「BBCスペシャル フランスの大自然 動物たちの物語」")
                XCTAssert(program.subTitle    == "BBCスペシャル フランスの大自然 動物たちの物語")
                XCTAssert(program.fullTitle   == "【二】地球紀行　「BBCスペシャル フランスの大自然 動物たちの物語」")
                XCTAssert(program.detail      == "「アルプス・世界遺産の城 そしてプロバンスへ」▽美しくも雄大な自然に恵まれたフランス。アルプスの山々や世界遺産の城など雄大な自然の中で暮らす野生動物たちに密着！")
                XCTAssert(program.start       == 1450518840000)
                XCTAssert(program.end         == 1450526040000)
                XCTAssert(program.seconds     == 7200)

                expectation.fulfill()
            case .Failure:
                // TODO なんかエラー表示する
                XCTFail()
            }
        }
        waitForExpectationsWithTimeout(3) { error in
            XCTAssertNil(error)
        }
    }
}
