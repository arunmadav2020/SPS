//
//  MockCocktailsAPI.swift
//  CocktailBookTests
//
//  Created by Arun Kumar on 29/12/2023.
//

import Foundation
@testable import CocktailBook


class MockCocktailsAPI: CocktailsAPI{
    var dataTaskCallCount = 0
    func fetchCocktails(_ completion: @escaping (Bool, CocktailBook.Cocktails?, CocktailBook.CocktailsAPIError?) -> Void) {
        dataTaskCallCount += 1
    }
    
    
}
