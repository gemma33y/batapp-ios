//
//  MapViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 15/11/24.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

    
    @IBOutlet weak var map: MKMapView!
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        
        print("Map")
    }
}


extension MapViewController: CLLocationManagerDelegate {
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

extension MapViewController: MKMapViewDelegate {
    /*
    // Cambiar estilo de la anotaciones (puntito del usuario también cuenta como anotación)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Si la anotación es la del usuario, sale de la función -> return nil. No queremos modificar el aspecto por defecto
        guard !(annotation is MKUserLocation) else {return nil}
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        annotationView.markerTintColor = .cyan
        
        annotationView.glyphText = "📍"
        
        return annotationView
        
    }*/
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Si la anotación es la del usuario, sale de la función -> return nil. No queremos modificar el aspecto por defecto
        guard !(annotation is MKUserLocation) else {return nil}
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        annotationView.image = UIImage(named: "Tux")
        
        return annotationView
        
    }
}
