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
        let cell = tableView.dequeueReusableCellWithIdentifier("RecordedCell", forIndexPath: indexPath)

        guard let recorded = recordedList?[indexPath.row] else {
            // FIXME
            return cell
        }
        cell.textLabel?.text = recorded.fullTitle

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordedList?.count ?? 0
    }
}
