//
//  ViewController1.swift
//  Parsing
//
//  Created by Aswathimol S(UST,IN) on 17/10/23.
//

import UIKit
import MapKit

class AnnotationPin: NSObject, MKAnnotation, MKMapViewDelegate {
    init(coordinate: CLLocationCoordinate2D,
         title: String? = nil,
         subtitle: String? = nil)
    {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
}

class ViewController1: UIViewController {
    
    var detailsOfUser1: User? = nil
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let user = detailsOfUser1 {
            let geo = user.address.geo
            if let latitude = Double(geo.lat), let longitude = Double(geo.lng) {
                mapView.addAnnotation(AnnotationPin(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
                mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            }
        }
      
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LOCATION DETALS"
    }
}




