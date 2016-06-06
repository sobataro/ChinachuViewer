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

    private let serverUrlKey = "serverUrl"

    private init() {
        userDefaults.registerDefaults([serverUrlKey: "http://localhost:10772/"])
    }

    var serverUrl: String {
        get {
            return userDefaults.objectForKey(serverUrlKey) as! String
        }
        set {
            // TODO: うまいことする
            userDefaults.setObject(newValue, forKey: serverUrlKey)
        }
    }

    var apiBaseUrl: String {
        // TODO: うまいことする
        if serverUrl.hasSuffix("/") {
            return serverUrl + "api"
        } else {
            return serverUrl + "/api"
        }
    }
}
