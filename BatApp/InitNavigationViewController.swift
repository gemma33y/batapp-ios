//
//  InitNavigationViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 17/11/24.
//

import UIKit
import CoreLocation

class InitNavigationViewController: UINavigationController {

    private let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self

    }
    

}


extension InitNavigationViewController: CLLocationManagerDelegate {
    // Usuario a aceptado/denegado
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Podemos hacer distintas cosas a partir de lo que haya aceptado o no el usuario
        // No determinado, aceptado, aceptado siempre, no aceptado -> SWITCH
        
        switch status{
            
        case .authorizedAlways, .authorizedWhenInUse:
            print("Authorized")
            
            
        case .denied:
            print("Denied")
            
        case .restricted:
            print("Restricted")
            
        case .notDetermined:
            print("Not Determined")
            
            // Llamamos al manager para pedirle autorización al usuario
            manager.requestAlwaysAuthorization()
            
        default:
            print("Default")
            
        }
    }
}
