//
//  RecordedDetailViewController.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/20.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Foundation
import UIKit

class RecordedDetailViewController: UIViewController {
    @IBOutlet weak var fullTitleLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var dateTimeDurationLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    var recorded: Recorded?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        fullTitleLabel.text        = recorded!.program.fullTitle
        channelLabel.text          = recorded!.program.channelName.hankakuOnlyNumberAlphabet
        dateTimeDurationLabel.text = recorded!.program.dateTimeDuration
        detailLabel.text           = recorded!.program.detail.hankakuOnlyNumberAlphabet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}