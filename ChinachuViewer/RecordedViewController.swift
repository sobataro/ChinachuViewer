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
        tableView.delegate = self

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
        let cell = tableView.dequeueReusableCellWithIdentifier("RecordedCell", forIndexPath: indexPath)
        guard let recorded = recordedList?[indexPath.row] else {
            // FIXME
            return cell
        }

        let channel          = cell.viewWithTag(1) as! UILabel
        let title            = cell.viewWithTag(2) as! UILabel
        let dateTimeDuration = cell.viewWithTag(3) as! UILabel

        channel.text = recorded.channelName.hankakuOnlyNumberAlphabet
        title.text   = recorded.title.hankakuOnlyNumberAlphabet
        dateTimeDuration.text = recorded.dateTimeDuration

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordedList?.count ?? 0
    }
}

extension RecordedViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let recorded = recordedList?[indexPath.row] else {
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let recordedDetailViewController = storyboard.instantiateViewControllerWithIdentifier("RecordedDetail") as! RecordedDetailViewController
        recordedDetailViewController.recorded = recorded

        self.navigationController?.pushViewController(recordedDetailViewController, animated: true)

//        presentViewController(recordedDetailViewController, animated: true, completion: nil)

        // FIXME
        //                 self?.navigationController?.pushViewController(viewController, animated: true)
        // 的なことをする

    }
}
