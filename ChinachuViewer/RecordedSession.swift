//
//  RecordedSession.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/16.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation
import Alamofire

class RecordedSession {
    class func fetchRecordedList(completionHandler: (json: AnyObject?, error: NSError?) -> Void) {
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: nil)
            .validate()
            .response { (request, response, data, error) in
                if let error = error {
                    completionHandler(json: nil, error: error)
                    // FIXME: result をつかって swifty にする
                }

                // FIXME: swiftyjson とか mapper とか使う
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
                completionHandler(json: json, error: nil)
        }
    }
}
