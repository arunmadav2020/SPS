//
//  UserDefaultsProtocol.swift
//  CocktailBook
//
//  Created by Arun Kumar on 29/12/2023.
//

import Foundation

protocol UserDefaultsProtocol {
    func saveInUserDefaults<T>(data :T, key :String)->Bool where T: Codable
    func retrieveFromUserDefaults<T>(dataType: T.Type, key: String)-> T? where T: Codable
}
