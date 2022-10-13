//
//  itemTwoController.swift
//  testingTableView
//
//  Created by Sean Devine on 31.07.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit

class itemTwoController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    

    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var testTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = self.testTableView.dequeueReusableCell(withIdentifier: "buttonCell") as! UITableViewCell
        
        cell.buttonOne?.text = self.names[indexPath.row]
        
        return cell
        
        
    }
    
    var names: [String] = ["APT", "Rounded Shoulders", "Hips"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.testTableView.register(UITableViewCell.self, forCellReuseIdentifier: "buttonCell")
        
        self.testTableView.register(UITableViewCell.self, forCellReuseIdentifier: "labelCell")
        
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
