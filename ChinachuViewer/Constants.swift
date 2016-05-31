//
//  Constants.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/25.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

final class Constants {
    static let apiScheme = "http"
    static let apiHost = "localhost"
    static let apiPort = "10772"
    static var apiBaseUrl: String {
        return String(format: "%@://%@:%@/api", arguments: [apiScheme, apiHost, apiPort])
    }
}
