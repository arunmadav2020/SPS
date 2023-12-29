//
//  UserDefaultsManager.swift
//  CocktailBook
//
//  Created by Arun Kumar on 12/12/2023.
//

import Foundation



struct UserDefaultsManager: UserDefaultsProtocol {
    static var shared = UserDefaultsManager()
    
    func saveInUserDefaults<T>(data :T, key :String)->Bool where T: Codable{
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)
            UserDefaults.standard.set(data, forKey: key)
            return true
        }
        catch{
            return false
        }
    }
    
    func retrieveFromUserDefaults<T>(dataType: T.Type, key: String)-> T? where T: Codable{
        
        if let data = UserDefaults.standard.data(forKey: key){
            do {
                let decoder = JSONDecoder()
                let values = try decoder.decode(dataType , from: data)
                return values
            }
            catch{
                return nil
            }
        }
        return nil
    }
    
}

struct Property: Codable, Equatable { }
