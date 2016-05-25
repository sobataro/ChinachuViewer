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

        Alamofire.request(.GET, url).validate().responseJSON { response in
            // FIXME ここはメインスレッドで実行される
            // cf. https://github.com/Alamofire/Alamofire/blob/2501fc92eaf2d4e6d0b316d8fb5bb2eb41311f86/Source/ResponseSerialization.swift#L86-L98
            // エンティティの解釈は別スレッドで実行して、UIの更新だけをメインスレッドで実行したい
            // こっちも参照 https://github.com/mixi-inc/iOSTraining/wiki/8.2-Grand-Central-Dispatch
            switch response.result {
            case .Success:
                guard let value = response.result.value else {
                    completionHandler(recordedList: nil, error: NSError(domain: apiClientErrorDomain, code: jsonParseErrorCode, userInfo: nil))
                    return
                }
                guard let json = JSON(value).array else {
                    completionHandler(recordedList: nil, error: NSError(domain: apiClientErrorDomain, code: jsonParseErrorCode, userInfo: nil))
                    return
                }
                let recordedList = json.map { (json) -> Recorded in
                    Recorded.from(json.dictionaryObject!)!
                }
                completionHandler(recordedList: recordedList, error: nil)
            case .Failure(let error):
                completionHandler(recordedList: nil, error: error)
            }
        }
    }
}
