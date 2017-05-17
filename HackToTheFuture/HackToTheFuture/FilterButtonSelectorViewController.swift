//
//  FilterButtonSelectorViewController.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit

protocol FilterButtonSelectorProtocol : class {
    func didChangeSwitch(_ type : FilterTypes, on : Bool)
}

class FilterButtonSelectorViewController: BaseViewController {

    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var labelCount : UILabel!
    @IBOutlet weak var switchFilter : UISwitch!
    @IBOutlet weak var button : UIButton!
    
    weak var delegate : FilterButtonSelectorProtocol?
    
    var type : FilterTypes = .notDefined
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor.gray.cgColor
        
        labelTitle.text = type.getTitle()
        labelCount.text = type.getNearMe()
        switchFilter.isHidden = type == .more
        button.isHidden = !switchFilter.isHidden
    }
    
    @IBAction func didPressSwitch(_ sender : UISwitch) {
        delegate?.didChangeSwitch(type, on: sender.isOn)
    }
    
    @IBAction func didPressButton() {
        delegate?.didChangeSwitch(type, on: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
