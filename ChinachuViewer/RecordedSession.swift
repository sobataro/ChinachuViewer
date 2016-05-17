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
        let url = "http://chinachu.sobataro.tk:10772/api/recorded.json"

        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    completionHandler(json: json, error: nil)
                }
            case .Failure(let error):
                completionHandler(json: nil, error: error)
            }
        }
    }
}
