//
//  IngredientsTableViewCell.swift
//  CocktailBook
//
//  Created by Arun Kumar on 12/12/2023.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var bulletImage: UIImageView!
    @IBOutlet weak var ingredientLabel: UILabel!
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: IngredientsCellViewModel?{
        didSet {
            ingredientLabel.text = cellViewModel?.ingredientName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
