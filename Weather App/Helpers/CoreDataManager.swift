//
//  CoreDataManager.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {
        
    }
    
    let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: CRUD Operations
    func saveContext() {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func addCity(city: WeatherData) {
        if let newCity = fetchCity(name: city.city) {
            newCity.name = city.city
            newCity.temperature = Double(city.temperature)
            newCity.condition = Double(city.condition)
            
            saveContext()
        } else {
            createCity(city: city)
        }
    }
    
    func createCity(city: WeatherData) {
        let newCity = City(context: context!)
        newCity.name = city.city
        newCity.temperature = Double(city.temperature)
        newCity.condition = Double(city.condition)
        
        saveContext()
    }
    
    func fetchCities() -> [City]? {
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        
        do {
            let cities = try context?.fetch(fetchRequest)
            return cities
        } catch {
            print("Failed to fetch cities")
        }
        
        return nil
    }
    
    func fetchCity(name: String) -> City? {
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        fetchRequest.fetchLimit = 1
        
        fetchRequest.predicate = NSPredicate(format: "name = %@",name)
        do {
            let cities = try context?.fetch(fetchRequest)
            return cities?.first
        } catch {
            print("Failed to fetch cities")
        }
        
        return nil
    }
    
    func updateCity(name: String) {
        
    }
}

