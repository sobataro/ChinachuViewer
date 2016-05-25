//
//  RecordedClient.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/25.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//
// An API client class for `/recorded` resource
//
class RecordedClient {
    static let apiClientErrorDomain = "apiClientErrorDomain"
    static let jsonParseErrorCode = -100

    static func fetchRecordedList(completionHandler: (recordedList: [Recorded]?, error: NSError?) -> Void) {
        let url = Constants().apiBaseUrl + "/recorded.json"

        Alamofire.request(.GET, url)
            .validate()
            .responseJSON(queue: GCD.global_default_queue(), options: NSJSONReadingOptions(), completionHandler: { (response) -> Void in
            switch response.result {
            case .Success:
                guard let value = response.result.value else {
                    GCD.dispatch_async_main {
                        completionHandler(recordedList: nil, error: NSError(domain: apiClientErrorDomain, code: jsonParseErrorCode, userInfo: nil))
                    }
                    return
                }
                guard let json = JSON(value).array else {
                    GCD.dispatch_async_main {
                        completionHandler(recordedList: nil, error: NSError(domain: apiClientErrorDomain, code: jsonParseErrorCode, userInfo: nil))
                    }
                    return
                }

                let recordedList = json.map { (json) -> Recorded in
                    Recorded.from(json.dictionaryObject!)!
                }
                GCD.dispatch_async_main {
                    completionHandler(recordedList: recordedList, error: nil)
                }
            case .Failure(let error):
                GCD.dispatch_async_main {
                    completionHandler(recordedList: nil, error: error)
                }
            }
        })
    }
}
