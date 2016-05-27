//
//  Recorded.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/16.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation
import Mapper

struct Recorded: Mappable {
    let program:  Program
    let tuner:    String
    let command:  String
    let filePath: String

    init(map: Mapper) throws {
        try program  = Program.init(map: map)
        try tuner    = map.from("tuner.name")
        try command  = map.from("command")
        try filePath = map.from("recorded")
    }
}
