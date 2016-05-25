//
//  GCD.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/25.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation

//
// see http://qiita.com/takabosoft/items/adef75dfa421837e996c
//
final class GCD {
    class func dispatch_async_main(block: () -> ()) {
        dispatch_async(dispatch_get_main_queue(), block)
    }

    class func dispatch_async_global(block: () -> ()) {
        dispatch_async(global_default_queue(), block)
    }

    class func global_default_queue() -> dispatch_queue_t {
        return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    }
}
