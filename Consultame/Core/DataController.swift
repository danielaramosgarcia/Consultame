//
//  DataController.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 27/11/23.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "DataController")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Algo esta fallando con el Core Data, ese algo es: \(error.localizedDescription)")
            }
        }
    }
    
}
