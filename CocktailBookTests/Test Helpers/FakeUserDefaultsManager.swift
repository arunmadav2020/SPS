//
//  FakeUserDefaultsManager.swift
//  CocktailBookTests
//
//  Created by Arun Kumar on 29/12/2023.
//

import Foundation
@testable import CocktailBook

class FakeUserDefaultsManager: UserDefaultsProtocol{
    
    var cocktails: [String] = []
    func saveInUserDefaults<T>(data: T, key: String) -> Bool where T : Decodable, T : Encodable {
        cocktails = data as? [String] ?? []
        return true
    }
    
    func retrieveFromUserDefaults<T>(dataType: T.Type, key: String) -> T? where T : Decodable, T : Encodable {
        cocktails as? T
    }
    
    
}
