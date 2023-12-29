//
//  ViewController+extension.swift
//  CocktailBook
//
//  Created by Arun Kumar on 12/12/2023.
//

import UIKit
import Foundation

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.center = view.center
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
