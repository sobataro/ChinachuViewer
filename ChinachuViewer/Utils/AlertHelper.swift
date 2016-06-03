//
//  AlertHelper.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/06/02.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import UIKit

class AlertHelper {
    class func showAlertDialog(viewController: UIViewController, title: String, message: String, actions: UIAlertAction...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        actions.forEach { (action) in
            alert.addAction(action)
        }
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}
