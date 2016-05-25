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
    let id:          String // "bs151-ess"
    let channelId:   String // "BS_151"
    let channelName: String // "ＢＳ朝日１"
    let category:    String // "etc"
    let title:       String // "地球紀行　「BBCスペシャル フランスの大自然 動物たちの物語」"
    let subTitle:    String // "BBCスペシャル フランスの大自然 動物たちの物語"
    let fullTitle:   String // "【二】地球紀行　「BBCスペシャル フランスの大自然 動物たちの物語」"
    let detail:      String // "「アルプス・世界遺産の城 そしてプロバンスへ」▽美しくも雄大な自然に恵まれたフランス。アルプスの山々や世界遺産の城など雄大な自然の中で暮らす野生動物たちに密着！"
    let start:       Int    // 1450518840000
    let end:         Int    // 1450526040000
    let seconds:     Int    // 7200

    var dateTimeDuration: String {
        get {
            // FIXME あとでうまいことする、 NSDateFormatter の extension つくるとか
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd\nHH:mm"

            let startDate = NSDate(timeIntervalSince1970: NSTimeInterval(start / 1000))
            let startDateString = dateFormatter.stringFromDate(startDate)
            let durationText    = (seconds / 60).description + "min"
            return startDateString + "\n" + durationText
        }
    }

    init(map: Mapper) throws {
        try id          = map.from("id")
        try channelId   = map.from("channel.id")
        try channelName = map.from("channel.name")
        try category    = map.from("category")
        try title       = map.from("title")
        try subTitle    = map.from("subTitle")
        try fullTitle   = map.from("fullTitle")
        try detail      = map.from("detail")
        try start       = map.from("start")
        try end         = map.from("end")
        try seconds     = map.from("seconds")
    }
}