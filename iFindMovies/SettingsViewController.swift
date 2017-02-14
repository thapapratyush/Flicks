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

    @IBOutlet weak var DarkSwitch: UITableViewCell!
    
    @IBOutlet weak var rando: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        if (self.rando.isOn){
            
        }
        else{
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieViewController = segue.destination as! MovieViewController
        movieViewController.randoMuji = self.rando.isOn
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
