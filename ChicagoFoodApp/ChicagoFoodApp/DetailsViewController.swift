//
//  DetailsViewController.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 5/9/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var risk: UILabel!
    @IBOutlet weak var violations: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var facilities: [Facility] = []
    var searchedFacility: [Facility] = []
  
    var facilityName: String = ""
    var facilityAddress: String = ""
    var facilityRisk: String = ""
    var facilityViolations: [String] = []
    var facilityFavorited: Bool = false
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var favorites: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Model.sharedInstance.loadData()
        facilities = Model.sharedInstance.fetchFacilities()
        
        searchedFacility = facilities.filter({ (element) -> Bool in
            return element.name == facilityName
        })
        
        /* Changes to Favorite Button Look */
        if(facilityFavorited == true){
            favoriteButton.setImage(UIImage(named: "Hearts-25"), for: UIControlState.normal)
        }
        else{
            favoriteButton.setImage(UIImage(named: "Hearts-25White"), for: UIControlState.normal)
        }
        
        
        name.text = facilityName
        address.text = facilityAddress

        risk.text = facilityRisk
        for violation in facilityViolations {
            violations.text = violation
        }
        if violations.text == "" {
            violations.text = "No comments about violations"
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func getDirections(_ sender: UIButton) {
        
        let thelatitude: CLLocationDegrees = latitude
        let thelongitude: CLLocationDegrees = longitude
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(thelatitude, thelongitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = facilityName
        mapItem.openInMaps(launchOptions: options)
        
    }

    
    /* Favorite/Track a restuarant */
    @IBAction func favorited(_ sender: UIButton) {
        if(facilityFavorited == false){
            searchedFacility[0].favorited = true
            do{
                try searchedFacility[0].managedObjectContext?.save()
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
            favoriteButton.setImage(UIImage(named: "Hearts-25"), for: UIControlState.normal)
        }
        else{
            searchedFacility[0].favorited = false
            do{
                try searchedFacility[0].managedObjectContext?.save()
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
            favoriteButton.setImage(UIImage(named: "Hearts-25White"), for: UIControlState.normal)
        }
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
