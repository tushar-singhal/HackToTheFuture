//
//  MenuSelectorViewController.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit

protocol MenuSelectorProtocol : class {
    func doSwipeUp()
    func doSwipeDown()
}

class MenuSelectorViewController: BaseViewController {

    @IBOutlet weak var button1 : UIButton!
    @IBOutlet weak var button2 : UIButton!
    @IBOutlet weak var button3 : UIButton!

    weak var delegate : MenuSelectorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSwipeUp() {
        delegate?.doSwipeUp()
    }
    
    @IBAction func didSwipeDown() {
        delegate?.doSwipeDown()
    }
    
    @IBAction func didPressButton1() {
        
    }

    @IBAction func didPressButton2() {
        
    }

    @IBAction func didPressButton3() {
        
    }
}
