//
//  RecordedManager.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/18.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation
import Alamofire // FIXME

class RecordedManager {
    func getRecordedList(completionHandler: (recordedList: [Recorded], result: Alamofire.Result) -> Void) {
        RecordedSession.fetchRecordedList { (json, result) in
            print(json)
        }
    }
}
