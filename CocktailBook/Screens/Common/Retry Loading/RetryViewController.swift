//
//  RetryViewController.swift
//  CocktailBook
//
//  Created by Arun Kumar on 28/12/2023.
//

import UIKit

class RetryViewController: UIViewController {

    var reloadButtonClicked: ((UIButton)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }


    @IBAction func reloadButtonClicked(_ sender: UIButton){
        reloadButtonClicked?(sender)
    }

}
