//
//  FirstViewController.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/12.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecordedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

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
}

extension RecordedViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // FIXME レイアウト崩れを直す
        let cell = tableView.dequeueReusableCellWithIdentifier("RecordedCell", forIndexPath: indexPath)
        let channel  = cell.viewWithTag(1) as! UILabel
        let title    = cell.viewWithTag(2) as! UILabel
        let dateTime = cell.viewWithTag(3) as! UILabel
        let duration = cell.viewWithTag(4) as! UILabel

        guard let recorded = recordedList?[indexPath.row] else {
            // FIXME
            return cell
        }
        channel.text  = recorded.channelName.hankakuOnlyNumberAlphabet //.stringByReplacingOccurrencesOfString("BS", withString: "BS\n")
        title.text    = recorded.title.hankakuOnlyNumberAlphabet
        dateTime.text = "?/?" // FIXME
        duration.text = (recorded.seconds / 60).description + "min"

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordedList?.count ?? 0
    }
}

extension RecordedViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let recordedDetailViewController = RecordedDetailViewController()
//        presentViewController(recordedDetailViewController, animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let recordedDetailViewController = storyboard.instantiateViewControllerWithIdentifier("RecordedDetail")
        presentViewController(recordedDetailViewController, animated: true, completion: nil) // FIXME doesn't work!
//        UIStoryboard.instantiateViewControllerWithIdentifier(
    }
}
