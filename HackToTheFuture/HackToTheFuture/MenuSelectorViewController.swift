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
    func doFilter(_ type : FilterTypes, on : Bool)
}

class MenuSelectorViewController: BaseViewController, FilterButtonSelectorProtocol {

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FilterButtonSelectorViewController {
            var type : FilterTypes = .notDefined
            if segue.identifier == "Btn1" {
                type = .atm
            } else if segue.identifier == "Btn2" {
                type = .branch
            } else if segue.identifier == "Btn3" {
                type = .store
            } else if segue.identifier == "Btn4" {
                type = .more
            }
            vc.type = type
            vc.delegate = self
        }
    }
    
    @IBAction func didSwipeUp() {
        delegate?.doSwipeUp()
    }
    
    @IBAction func didSwipeDown() {
        delegate?.doSwipeDown()
    }
    
    func didChangeSwitch(_ type: FilterTypes, on: Bool) {
        if type == .more {
            delegate?.doSwipeUp()
        } else {
            delegate?.doFilter(type, on: on)
        }
    }
    
    @IBAction func didPressButton1() {
        
    }

    @IBAction func didPressButton2() {
        
    }

    @IBAction func didPressButton3() {
        
    }
}
