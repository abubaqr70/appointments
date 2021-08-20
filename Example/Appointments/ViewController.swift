//
//  ViewController.swift
//  Appointments
//
//  Created by Hussaan S on 08/20/2021.
//  Copyright © 2021 Caremerge. All rights reserved.
//

import UIKit
import Appointments

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }

}

