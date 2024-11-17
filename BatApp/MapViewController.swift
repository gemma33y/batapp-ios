//
//  MapViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 15/11/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    
    @IBOutlet weak var map: MKMapView!
    
    var enemies: [Enemy]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        
        // Access the FirstViewController from the TabBarController
        if let tabBarController = self.tabBarController,
           let firstVC = tabBarController.viewControllers?[0] as? HomeViewController {
            // Get the elements from the first view controller
            self.enemies = firstVC.enemies
        }
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var targetName = "Bane"
        var index = enemies?.firstIndex(where: { $0.name == targetName })
        
        // Llamamos a la función para crear y agregar una anotación personalizada
        addCustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),  // Los Angeles (Centro)
                            title: targetName,
                            subtitle: "Es muy malo.",
                            id: index ?? 0,
                            imageName: "BaneIMG")

        targetName = "Harley Quinn"
        index = enemies?.firstIndex(where: { $0.name == targetName })

        addCustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 34.0736, longitude: -118.4004),  // West Hollywood
                            title: targetName,
                            subtitle: "Es muy mala.",
                            id: index ?? 0,
                            imageName: "HarleyQuinnIMG")

        targetName = "Joker"
        index = enemies?.firstIndex(where: { $0.name == targetName })
        
        addCustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 34.1397, longitude: -118.1270),  // Beverly Hills
                            title: targetName,
                            subtitle: "Es muy muy malo.",
                            id: index ?? 0,
                            imageName: "JokerIMG")


        
    }
   
   // Función para crear y agregar anotaciones personalizadas
   func addCustomAnnotation(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, id: Int, imageName: String) {
       // Crear la anotación personalizada
       let annotation = CustomAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, id: id, imageName: imageName)
       
       // Añadir la anotación al mapa
       map.addAnnotation(annotation)
       
       // Centrar el mapa en la anotación
       let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
       map.setRegion(region, animated: true)
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromMapToEnemy" {

            if let destination = segue.destination as? DetailsEnemyViewController,
               let id = sender as? Int {  // Get the index of the enemy clicked
                
                let enemy = enemies?[id]
                
                destination.nameEnemyText = enemy?.name
                destination.imageEnemyImage = UIImage(named: enemy?.imageURL ?? "")
                destination.descriptionEnemyText = enemy?.description
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
   // Cambiar estilo de la anotación
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
       // Si la anotación es la ubicación del usuario, personalizarla
       if let userLocation = annotation as? MKUserLocation {
           var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "userLocation")
           
           if annotationView == nil {
               annotationView = MKAnnotationView(annotation: userLocation, reuseIdentifier: "userLocation")
           }
           
           // Establecer la imagen personalizada para la ubicación del usuario
           annotationView?.image = UIImage(named: "batmanIMG")
           annotationView?.canShowCallout = true
           
           return annotationView
       }
       
       // Si la anotación es la del usuario, sale de la función -> return nil. No queremos modificar el aspecto por defecto
       guard !(annotation is MKUserLocation) else { return nil }
       
       let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
       
       // Establecer la imagen para el pin
       if let customAnnotation = annotation as? CustomAnnotation {
           annotationView.image = UIImage(named: customAnnotation.imageName ?? "")
           
           // Establecer el título y subtítulo en el callout (burbuja)
           annotationView.canShowCallout = true
           annotationView.annotation = annotation
       }
       
       
       return annotationView
   }
   
   // Detectar cuando el usuario hace clic en la anotación
   func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
       if let customAnnotation = annotation as? CustomAnnotation {
           print("Annotation with ID \(customAnnotation.id) was selected!")
           
           performSegue(withIdentifier: "fromMapToEnemy", sender: customAnnotation.id)
       }
   }
}
