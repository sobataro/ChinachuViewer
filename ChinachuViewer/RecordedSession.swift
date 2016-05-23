//
//  RecordedSession.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/16.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RecordedSession {
    class func fetchRecordedList(completionHandler: (json: JSON?, error: NSError?) -> Void) {
//        let url = "http://chinachu.sobataro.tk:10772/api/recorded.json"
        let url = "http://localhost:10772/api/recorded.json"

        Alamofire.request(.GET, url).validate().responseJSON { response in
            // FIXME ここはメインスレッドで実行される
            // cf. https://github.com/Alamofire/Alamofire/blob/2501fc92eaf2d4e6d0b316d8fb5bb2eb41311f86/Source/ResponseSerialization.swift#L86-L98
            // エンティティの解釈は別スレッドで実行して、UIの更新だけをメインスレッドで実行したい
            // こっちも参照 https://github.com/mixi-inc/iOSTraining/wiki/8.2-Grand-Central-Dispatch
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    completionHandler(json: JSON(value), error: nil)
                }
            case .Failure(let error):
                completionHandler(json: nil, error: error)
            }
        }
    }
}
