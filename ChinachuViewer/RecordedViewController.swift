//
//  FirstViewController.swift
//  ChinachuViewer
//
//  Created by kosuke.matsuishi on 2016/05/12.
//  Copyright © 2016年 松石 浩輔. All rights reserved.
//

import UIKit

class RecordedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let urlSession = NSURLSession.sharedSession()
        let url = NSURL(string: "http://chinachu.sobataro.tk:10772/api/recorded.json")!
        let task = urlSession.dataTaskWithURL(url) { (data, response, error) in
            guard let data = data else {
                return
            }
            let json = try! NSJSONSerialization.JSONObjectWithData(data, options: [])
            print(json)
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

