//
//  Untitled.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 17/11/24.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    var id: Int
    
    var imageName: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, id: Int, imageName: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.id = id
        self.imageName = imageName
    }
}
