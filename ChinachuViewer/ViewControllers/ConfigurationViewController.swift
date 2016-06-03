//
//  ConfigurationViewController.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/06/03.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import Former

class ConfigurationViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // FIXME: below codes are same as sample codes!
        let labelRow = LabelRowFormer<FormLabelCell>()
            .configure { row in
                row.text = "Label Cell"
            }.onSelected { row in
                // Do Something
        }
        let inlinePickerRow = InlinePickerRowFormer<FormInlinePickerCell, Int>() {
            $0.titleLabel.text = "Inline Picker Cell"
            }.configure { row in
                row.pickerItems = (1...5).map {
                    InlinePickerItem(title: "Option\($0)", value: Int($0))
                }
            }.onValueChanged { item in
                // Do Something
        }
        let header = LabelViewFormer<FormLabelHeaderView>() { view in
            view.titleLabel.text = "Label Header"
        }
        let section = SectionFormer(rowFormer: labelRow, inlinePickerRow)
            .set(headerViewFormer: header)
        former.append(sectionFormer: section)

        // TODO
        let configuration = Configuration.instance
        print(configuration.serverAddress)
    }
}
