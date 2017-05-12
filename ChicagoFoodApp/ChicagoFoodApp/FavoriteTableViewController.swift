//
//  FavoriteTableViewController.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 5/10/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    @IBOutlet var facilityTableView: UITableView!
    
    var facilities: [Facility] = []
    var numOfFavorites = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Model.sharedInstance.loadData()
        facilities = Model.sharedInstance.fetchFacilities()
  
        for facility in facilities {
            if facility.favorited == true{
                numOfFavorites += 1
            }
        }
//        print(numOfFavorites)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numOfFavorites
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritetablecell", for: indexPath)

        if let cell = cell as? FavoriteTableViewCell {
            cell.facilityName.text = facilities[indexPath.row].name ?? ""
            
            if(facilities[indexPath.row].risk == 1){
                cell.facilityImage.image = UIImage.init(named: "risk1List")
            }else if(facilities[indexPath.row].risk == 2){
                cell.facilityImage.image = UIImage.init(named: "risk2List")
            }else{
                cell.facilityImage.image = UIImage.init(named: "risk3List")
            }
            
        }

        return cell
    }
 
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController,
            let row = facilityTableView.indexPathForSelectedRow?.row{
            
            destination.facilityName = facilities[row].name ?? ""
            destination.facilityAddress = facilities[row].address ?? ""
            if let riskValue = facilities[row].risk {
                if riskValue == 1 {
                    destination.facilityRisk = "Risk 1 (High)"
                }
                else if riskValue == 2 {
                    destination.facilityRisk = "Risk 2 (Medium)"
                }
                else if riskValue == 3 {
                    destination.facilityRisk = "Risk 3 (Low)"
                }
                else{
                    destination.facilityRisk = "Not applicable"
                }
                
            }
            
            if let inspections = facilities[row].inspectionArray{
                for inspection in inspections{
                    if let violation = inspection.violation{
                        destination.facilityViolations.append(violation)
                    }
                }
            }
            destination.latitude = facilities[row].latitude
            destination.longitude = facilities[row].longitude
            destination.favorites = facilities[row].favorited
            
            
        }
    }
 

}
