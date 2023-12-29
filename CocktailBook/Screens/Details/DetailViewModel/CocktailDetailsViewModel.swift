//
//  CocktailDetailViewModel.swift
//  CocktailBook
//
//  Created by Arun Kumar on 11/12/2023.
//

import Foundation

protocol CocktailDetailsViewModelProtocol{
    func getCellViewModel(at indexPath: IndexPath) -> IngredientsCellViewModel?
}

struct CocktailDetailsViewModel: CocktailDetailsViewModelProtocol {
    var identifier: String
    var name: String
    var preparationTime: Int
    var imageName: String
    var longDescription: String
    var favourite: Bool = false
    var ingredients: [String]
    
    func getCellViewModel(at indexPath: IndexPath) -> IngredientsCellViewModel? {
        let name = ingredients[indexPath.row]
        return IngredientsCellViewModel(ingredientName: name)
    }
    
    
}
