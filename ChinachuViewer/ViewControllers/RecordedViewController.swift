//
//  FirstViewController.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/12.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import UIKit
import SwiftyJSON
import Result

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

        RecordedClient.fetchRecordedList { result in
            switch result {
            case .Success:
                self.recordedList = result.value
                print(self.recordedList)
                self.tableView.reloadData()

                // TODO recordedList が nil または .count==0 の場合にエラー表示する
            case .Failure:
                // TODO なんかエラー表示する
                print(result.error)
            }
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

        channel.text          = recorded.program.channelName.hankakuOnlyNumberAlphabet
        title.text            = recorded.program.title.hankakuOnlyNumberAlphabet
        dateTimeDuration.text = recorded.program.dateTimeDuration.stringByReplacingOccurrencesOfString(" ", withString: "\n")

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
        // FIXME navigationController のデザインとか
    }
}
