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
        try tuner    = map.from("tuner.name") // PT3-S2
        try command  = map.from("command")    // recpt1 --device /dev/pt3video1 --b25 --strip --sid 151 151 - -
        try filePath = map.from("recorded")   // /tank/record/[151219-1854][BS151][PT3-S2]地球紀行　「BBCスペシャル フランスの大自然 動物たちの物語」.m2ts
    }
}
