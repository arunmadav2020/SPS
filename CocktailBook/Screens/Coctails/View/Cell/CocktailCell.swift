//
//  CocktailCell.swift
//  CocktailBook
//
//  Created by Arun Kumar on 09/12/2023.
//

import UIKit

class CocktailCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var favouriteFlag: UIImageView!
    let favouritedColor = UIColor.systemPurple
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: CocktailCellViewModel?{
        didSet {
            nameLabel.text = cellViewModel?.name
            shortDescriptionLabel.text = cellViewModel?.shortDescription
            setupColorChangeForFavourites(favourite: cellViewModel?.favourite ?? false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupColorChangeForFavourites(favourite: Bool){
        if (favourite == true){
            nameLabel.textColor = favouritedColor
            favouriteFlag.isHidden = false
        }
        else{
            nameLabel.textColor = UIColor.label
            favouriteFlag.isHidden = true
        }
    }
    
}
