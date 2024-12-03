//
//  Equipment.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 30/10/24.
//


import Foundation

// Marca la estructura como pública si necesitas acceder a ella desde otros módulos (o frameworks)
public struct Equipment {
    public let name: String
    public let description: String
    public let imageURL: String
    
    // Inicializador
    public init(name: String, description: String, imageURL: String) {
        self.name = name
        self.imageURL = imageURL
        self.description = description
    }
}
