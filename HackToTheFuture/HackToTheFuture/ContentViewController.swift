//
//  ContentViewController.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit
import RealmSwift

class InfoObject: NSObject {
    var title : String = ""
    var image : UIImage? = nil
    var url : String = ""
}

var currentIndex = ""

class ContentViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellId = "CellContent"
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib.init(nibName: "ContentListTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView.estimatedRowHeight = 80
        self.tableView.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    var array: Results<BeaconRecord> {
        get {
            let predicate = Filters().predicate(all: true)
            let results = realm.objects(BeaconRecord.self).filter(predicate).sorted(byKeyPath: "title", ascending: true)
            return results
        }
    }
    
    func getRecord(_ index : Int) ->BeaconRecord {
        if index < self.array.count {
            return self.array[index]
        } else {
            return BeaconRecord()
        }
    }
    
    func refreshData() {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "Web" {
            if let vc = segue.destination as? WebViewController,
                let rec = sender as? BeaconRecord {
                vc.info = InfoObject()
                vc.info.title = rec.title
                vc.info.url = rec.contactWebsite
            }
        }
    }

}

extension ContentViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rec = self.getRecord(indexPath.row)
        
        let cell : ContentListTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContentListTableViewCell
        cell.configure(rec)
        return cell
    }
}

extension ContentViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let rec = self.getRecord(indexPath.row)
        self.performSegue(withIdentifier: "Web", sender: rec)
    }
}

