//
//  MapViewController.swift
//  maplocation
//
//  Created by cosine on 2016/3/27.
//  Copyright © 2016年 Lin Circle. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate{
    
    
    @IBOutlet weak var map_view: MKMapView!
    
    private let _Location_Manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map_view.delegate = self
        
        _Location_Manager.requestWhenInUseAuthorization()
        
        self.map_view.showsUserLocation = true
        
        //self.map_view.showsCompass = true
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        map_view.centerCoordinate = userLocation.coordinate
        
        _zoom(userLocation.coordinate, animated: true)
        
        

    }
    
    private func _zoom(coordinate: CLLocationCoordinate2D, animated: Bool) {
        
        var region = MKCoordinateRegion()
        
        region.center = coordinate
        
         region.span.latitudeDelta = 0.01
         region.span.longitudeDelta = 0.01
        
        
        self.map_view.setRegion(region, animated: animated)
        
    }
}
