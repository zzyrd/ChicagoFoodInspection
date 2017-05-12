//
//  AllTableViewController.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 5/9/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import UIKit



class AllTableViewController: UITableViewController,UISearchResultsUpdating{
    
    
    
    @IBOutlet var allFacilitiesTable: UITableView!
    
    var facilities: [Facility] = []
    var filterFacility : [Facility] = []
    var searchController: UISearchController!
    
    func filter(_ searchText: String) -> Array<Facility> {
        
        var filterFacility = Array<Facility>()
        
        if searchText.isEmpty {
            filterFacility = facilities
            
        }
        else {
            
            for facility in facilities {
                
                if facility.name?.range(of: searchText, options: .caseInsensitive) != nil {
                        filterFacility.append(facility)
                    
                }
                else if facility.description.range(of: searchText, options: .caseInsensitive) != nil {
                        filterFacility.append(facility)
                    
                }
                
            }
            
        }
        
        return filterFacility
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Model.sharedInstance.loadData()
        facilities = Model.sharedInstance.fetchFacilities()
        
//        print("-------------------")
//        print(facilities.count)
        
    
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        allFacilitiesTable.tableHeaderView = searchController.searchBar
        
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterFacility.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "allfacilitiescell", for: indexPath)
        if let cell = cell as? AllFacilityTableViewCell {
            
            cell.facilityAddress.text = filterFacility[indexPath.row].address ?? ""
            cell.facilityName.text = filterFacility[indexPath.row].name ?? ""
            cell.facilityType.text = filterFacility[indexPath.row].type ?? ""
            if cell.facilityType.text == "" {
                cell.facilityType.text = "Not available"
            }
            if(facilities[indexPath.row].risk == 1){
                cell.photoView.image = UIImage.init(named: "risk1List")
            }else if(facilities[indexPath.row].risk == 2){
                cell.photoView.image = UIImage.init(named: "risk2List")
            }else{
                cell.photoView.image = UIImage.init(named: "risk3List")
            }
            
        }
        
        return cell
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterFacility = filter(searchText)
            allFacilitiesTable.reloadData()
            
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailsViewController,
            let row = allFacilitiesTable.indexPathForSelectedRow?.row{
            
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
