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
import Async

//
// An API client class for `/recorded` resource
//
class RecordedClient {
    static let path = "/recorded.json"

    enum APIError: ErrorType {
        case NetworkError
        case JSONParseError
    }

    static func fetchRecordedList(completionHandler: (Result<[Recorded], APIError>) -> Void) {
        let url = Constants.apiBaseUrl + path

        Alamofire.request(.GET, url)
            .validate()
            .responseJSON(queue: GCD.global_default_queue(), options: NSJSONReadingOptions(), completionHandler: { (response) -> Void in
            switch response.result {
            case .Success:
                guard let value = response.result.value else {
                    Async.main {
                        completionHandler(.Failure(.JSONParseError))
                    }
                    return
                }
                guard let json = JSON(value).array else {
                    Async.main {
                        completionHandler(.Failure(.JSONParseError))
                    }
                    return
                }

                let recordedList = json.map { (json) -> Recorded in
                    Recorded.from(json.dictionaryObject!)!
                }
                Async.main {
                    completionHandler(.Success(recordedList))
                }
            case .Failure:
                Async.main {
                    completionHandler(.Failure(.NetworkError))
                }
            }
        })
    }
}
