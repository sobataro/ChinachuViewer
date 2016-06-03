//
//  Configuration.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/06/03.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation

// FIXME: Dependency Injection する
final class Configuration {
    static let instance = Configuration()
    private let userDefaults = NSUserDefaults.standardUserDefaults()

    private let serverAddressKey = "serverAddress"

    private init() {
        userDefaults.registerDefaults([serverAddressKey: "http://localhost:10772/"])
    }

    var serverAddress: String {
        get {
            return userDefaults.objectForKey(serverAddressKey) as! String
        }
        set {
            userDefaults.setObject(newValue, forKey: serverAddressKey)
        }
    }
}
