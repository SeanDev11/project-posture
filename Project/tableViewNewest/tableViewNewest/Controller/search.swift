//
//  search.swift
//  tableViewNewest
//
//  Created by Sean Devine on 02.08.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import UIKit

class search: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        testTableView.delegate = self
        testTableView.dataSource = self
        
        
        
        
        // Do any additional setup after loading the view.
        
        testTableView.register(UINib(nibName: "customCell", bundle: nil), forCellReuseIdentifier: "configureCell")
        
    }
    
    
    @IBOutlet weak var testTableView: UITableView!
    
    let mainTextArray = ["Select Target Areas:", "Select Equipment:", "Set Time Limit:"]
    
    let subTextArray = ["Current:", "Current:", "Average Workout Time:"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = testTableView.dequeueReusableCell(withIdentifier: "configureCell", for: indexPath) as! customCell
        
        cell.targetAreas.text = mainTextArray[indexPath.row]
        cell.currentSelection.text = subTextArray[indexPath.row]
        
        return cell
        
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
