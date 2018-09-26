//
//  ViewController.swift
//  App List
//
//  Created by Jeffrey Ip on 2018-09-24.
//  Copyright © 2018 nil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APIClient.fetchPaidApps(completion: { _ in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

