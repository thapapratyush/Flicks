//
//  SettingsViewController.swift
//  iFindMovies
//
//  Created by Pratyush Thapa on 2/12/17.
//  Copyright © 2017 Pratyush. All rights reserved.
//

import UIKit


protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: String)
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var viewzzz: UITableView!
    @IBOutlet weak var DarkSwitch: UITableViewCell!
    
    var DarkOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DarkAction(_ sender: Any) {
        DarkSwitch?.userDidEnterInformation(info: DarkOn!)
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
