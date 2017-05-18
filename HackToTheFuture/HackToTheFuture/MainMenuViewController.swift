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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BeaconLoader().load()
        let _ = BeaconManager.shared

        NotificationCenter.default.addObserver(self, selector: #selector(MainMenu.alertBeacon), name: BeaconManager.shared.kNotifBeacon, object: nil)
   }
    
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
        let height = UIScreen.main.bounds.height
        if constraintHeight.constant > height * 0.75 {
            return
        } else if constraintHeight.constant == height / 2 {
            constraintHeight.constant = height * 0.9
        } else {
            constraintHeight.constant = height / 2
        }
        
        containerMenuSelector.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.containerMenuSelector.isUserInteractionEnabled = true
        }
    }
    
    func doSwipeDown() {
        let height = UIScreen.main.bounds.height
        if constraintHeight.constant < height / 2 {
            return
        } else if constraintHeight.constant == height / 2 {
            constraintHeight.constant = height * 0.2
        } else {
            constraintHeight.constant = height / 2
        }
        
        containerMenuSelector.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.containerMenuSelector.isUserInteractionEnabled = true
        }
    }
    
    func doFilter(_ type : FilterTypes, on : Bool) {
        if on {
            if !arrayFilters.contains(type) {
                arrayFilters.append(type)
            }
        } else {
            if let index = arrayFilters.index(of: type) {
                arrayFilters.remove(at: index)
            }
        }        
    }

    func alertBeacon(notif : Notification) {
        if let object = notif.object as? String {
            print (object)
            let alert = UIAlertController(title: "Hack to the Future" , message: object, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
