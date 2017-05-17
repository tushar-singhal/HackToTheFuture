//
//  MainMenu.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit

class MainMenu: BaseViewController, MenuSelectorProtocol {

    @IBOutlet weak var constraintHeight : NSLayoutConstraint!
    @IBOutlet weak var containerMap : UIView!
    @IBOutlet weak var containerMenuSelector : UIView!
    
    var firstTime = true
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let vc = segue.destination as? MenuSelectorViewController {
            vc.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if firstTime {
            constraintHeight.constant = UIScreen.main.bounds.height / 2
        }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if firstTime {
            doSwipeDown()
            firstTime = false
        }
    }
    
    func doSwipeUp() {
        containerMenuSelector.isUserInteractionEnabled = false
        
        let height = UIScreen.main.bounds.height
        if constraintHeight.constant > height * 0.75 {
            return
        } else if constraintHeight.constant == height / 2 {
            constraintHeight.constant = height * 0.9
        } else {
            constraintHeight.constant = height / 2
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.containerMenuSelector.isUserInteractionEnabled = true
        }
    }
    
    func doSwipeDown() {
        containerMenuSelector.isUserInteractionEnabled = false
        
        let height = UIScreen.main.bounds.height
        if constraintHeight.constant < height / 2 {
            return
        } else if constraintHeight.constant == height / 2 {
            constraintHeight.constant = height * 0.2
        } else {
            constraintHeight.constant = height / 2
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.containerMenuSelector.isUserInteractionEnabled = true
        }
    }
}
