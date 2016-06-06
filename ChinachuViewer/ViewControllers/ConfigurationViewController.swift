//
//  ConfigurationViewController.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/06/03.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import UIKit
import Former

class ConfigurationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private lazy var former: Former = Former(tableView: self.tableView)

    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = Configuration.instance

        let serverAddressRow = TextViewRowFormer<FormTextViewCell>() { view in
                view.titleLabel.text = "Server URL"
            }
            .configure { row in
                row.text = configuration.serverUrl
            }
            .onTextChanged { text in
                configuration.serverUrl = text ?? ""
            }

        let serverSectionHeader = LabelViewFormer<FormLabelHeaderView>()
            .configure { row in
                row.text = "Server Settings"
            }
        let serverSection = SectionFormer(rowFormer: serverAddressRow)
            .set(headerViewFormer: serverSectionHeader)

        former.append(sectionFormer: serverSection)
        former.endEditing()
    }
}
