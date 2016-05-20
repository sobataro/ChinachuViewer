//
//  FirstViewController.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/12.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecordedViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    let recordedCellChannelTag  = 1
    let recordedCellTitleTag    = 2
    let recordedCellDateTimeTag = 3
    let recordedCellDurationTag = 4

    var recordedList: [Recorded]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        RecordedManager.getRecordedList { (recordedList, error) in
            self.recordedList = recordedList
            print(recordedList)
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // FIXME レイアウト崩れを直す
        let cell = tableView.dequeueReusableCellWithIdentifier("RecordedCell", forIndexPath: indexPath)
        let channel  = cell.viewWithTag(recordedCellChannelTag)  as! UILabel
        let title    = cell.viewWithTag(recordedCellTitleTag)    as! UILabel
        let dateTime = cell.viewWithTag(recordedCellDateTimeTag) as! UILabel
        let duration = cell.viewWithTag(recordedCellDurationTag) as! UILabel

        guard let recorded = recordedList?[indexPath.row] else {
            // FIXME
            return cell
        }
        channel.text  = recorded.channelName
        title.text    = recorded.title
        dateTime.text = "?/?" // FIXME
        duration.text = (recorded.seconds / 60).description + "min"

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordedList?.count ?? 0
    }
}
