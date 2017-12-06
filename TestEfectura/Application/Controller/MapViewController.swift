//
//  ViewController.swift
//  TestEfectura
//
//  Created by Руслан on 05.12.2017.
//  Copyright © 2017 Руслан. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var temprLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func getWeatherButton(_ sender: UIButton) {
        NetworkService.shared.getData { (response) in
                self.countryLabel.text = response.location.country ?? ""
                self.regionLabel.text = response.location.region ?? ""
                self.temprLabel.text = String(describing: "\(response.current.temp_c)°")
                let imgURL = NSURL(string: "http:\(response.current.condition.icon!)")
                if imgURL != nil {
                    let data = NSData(contentsOf: (imgURL as URL?)!)
                    self.imageWeather.image = UIImage(data: data! as Data)
                }
            
        }
    }
    
}


extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.03, 0.03)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
    
        self.mapView.showsUserLocation = true
    }
}


