//
//  TestViewController.swift
//  JohnTest
//
//  Created by John Tan on 3/13/20.
//  Copyright © 2020 John Tan. All rights reserved.
//

import UIKit
import Branch

class TestViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    fileprivate var resultText = String()
    
    
    convenience init(with newText: String) {
        self.init()
        resultText = newText
        result.text = newText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BranchEvent.standardEvent(.viewItem, withContentItem: BranchUniversalObject(title: resultText)).logEvent()

        // Do any additional setup after loading the view.
    }

}
