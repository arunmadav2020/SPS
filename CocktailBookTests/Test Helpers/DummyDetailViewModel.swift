//
//  DummyDetailViewModel.swift
//  CocktailBookTests
//
//  Created by Arun Kumar on 29/12/2023.
//

import UIKit
import Foundation
@testable import CocktailBook

struct DummyDetailViewModel: CocktailDetailsViewModelProtocol{
    func getCellViewModel(at indexPath: IndexPath) -> IngredientsCellViewModel? {
        IngredientsCellViewModel(ingredientName: "Lemon")
    }
}
