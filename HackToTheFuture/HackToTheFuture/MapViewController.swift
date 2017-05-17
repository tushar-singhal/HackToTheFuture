//
//  MapViewController.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {

    @IBOutlet weak var mapView : MKMapView!
    @IBOutlet weak var buttonAR : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonAR.layer.cornerRadius = buttonAR.frame.size.width / 2
        buttonAR.clipsToBounds = true
        buttonAR.layer.borderWidth = 2.0
        buttonAR.layer.borderColor = UIColor.darkGray.cgColor
        
        mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressAR() {
        self.performSegue(withIdentifier: "AR", sender: nil)
    }

}
