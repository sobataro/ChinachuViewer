//
//  RecordedManager.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/18.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation

class RecordedManager {
    static let apiClientErrorDomain = "apiClientErrorDomain"
    static let jsonParseErrorCode = -100

    static func getRecordedList(completionHandler: (recordedList: [Recorded]?, error: NSError) -> Void) {
        RecordedSession.fetchRecordedList { (json, result) in
            guard let json = json else {
                completionHandler(recordedList: nil, error: NSError(domain: apiClientErrorDomain, code: jsonParseErrorCode, userInfo: nil))
                return
            }
            let recordedList = json.map({ (json) -> Recorded in
                Recorded.from(json.dictionaryObject!)!
            })
            completionHandler(json: recordedList, error: nil)
        }
    }
}
