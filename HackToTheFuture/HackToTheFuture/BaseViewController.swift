//
//  BaseViewController.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var buttonBack : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roundButton(buttonBack)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedBack() {
        self.dismiss(animated: true) { 
            
        }
    }
    
    func showMessage(_ message: String, completionHandler:@escaping () -> Void) {
        let alertController = UIAlertController(title: "Hack To The Future", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) -> Void in
            completionHandler()
        }
        
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func roundButton(_ btn : UIButton?) {
        if let button = btn {
            button.layer.cornerRadius = button.frame.size.width / 2
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.gray.cgColor
            button.clipsToBounds = true
        }
    }
}
