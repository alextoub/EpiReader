//
//  AboutTVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 23/09/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import MapKit

class AboutTVC: UITableViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet weak var versionLabel: UILabel!
    
    let initialLocation = CLLocation(latitude: 48.8156, longitude: 2.3631)
    let regionRadius: CLLocationDistance = 100
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
        versionLabel.text = appVersionValue()
    }
    
    // MARK: - Custom functions
    
    func appVersionValue() -> String {
        guard let version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return ""
        }
        let vers = "Version \(version)"
        return vers
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapKitView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let url : URL = URL(string: "http://www.epimac.org/")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
