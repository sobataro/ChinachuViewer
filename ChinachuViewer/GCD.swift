//
//  GCD.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/25.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation

final class GCD {
    class func global_default_queue() -> dispatch_queue_t {
        return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    }
}
