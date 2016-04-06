//
//  LocationViewController.swift
//  maplocation
//
//  Created by cosine on 2016/3/27.
//  Copyright © 2016年 Lin Circle. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var show_lng: UILabel!
    
    @IBOutlet weak var show_lat: UILabel!
    
    @IBOutlet weak var delta: UILabel!
    
    @IBOutlet weak var natwest: UILabel!
    
    @IBOutlet weak var alt: UILabel!
    
    @IBOutlet weak var alt_delta: UILabel!
    
    @IBOutlet weak var angle_delta: UILabel!
    
    
    private var _location_manager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        _location_manager.requestWhenInUseAuthorization()
        
        _location_manager.delegate = self
        
        //_location_manager.headingFilter = 3
        
    }
    override func viewWillAppear(animated: Bool) {
        
        _location_manager.startUpdatingLocation()
        _location_manager.startUpdatingHeading()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        _location_manager.stopUpdatingLocation()
        _location_manager.stopUpdatingHeading()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let _CURRENT_LOCATION = locations[0]
        
        print(_CURRENT_LOCATION)
        
        print(_CURRENT_LOCATION.verticalAccuracy)
        
        print(_CURRENT_LOCATION.horizontalAccuracy)
        
        let lat = self.roundDouble(_CURRENT_LOCATION.coordinate.latitude, places: 5)
        let lng = self.roundDouble(_CURRENT_LOCATION.coordinate.longitude, places: 5)
        
        self.show_lat.text = "緯度：\(lat)"
        self.show_lng.text = "經度：\(lng)"
        self.delta.text = "誤差：± \(_CURRENT_LOCATION.horizontalAccuracy) 公尺"
        self.alt.text = "海拔：\(_CURRENT_LOCATION.altitude) 公尺"
        self.alt_delta.text = "海拔誤差：±\(_CURRENT_LOCATION.verticalAccuracy) 公尺"
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        self.natwest.text = (0 <= newHeading.headingAccuracy) ? "\(round(newHeading.magneticHeading))" : ""
        
        self.natwest.text = "角度：\(self.natwest.text!) ° "
        self.angle_delta.text = "角度誤差：±\(newHeading.headingAccuracy) ° "
        
    }
    
    func roundDouble(number:Double,places:Int)->Double{
        
        let multiplier = pow(10.0, Double(places))
        return round(number * multiplier) / multiplier
        
    }

}
