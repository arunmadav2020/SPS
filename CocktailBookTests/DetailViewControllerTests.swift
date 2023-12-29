//
//  DetailViewControllerTests.swift
//  CocktailBookTests
//
//  Created by Arun Kumar on 12/12/2023.
//

import XCTest
@testable import CocktailBook



final class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController?
    var viewModel = DummyDetailViewModel()
    
    override func setUp() {
        super.setUp()
        sut = DetailViewController(viewModel: viewModel)
        _ = UINavigationController(rootViewController: sut!)
        sut?.loadViewIfNeeded()
    }
    
    func test_tappingFavouriteButton(){
        XCTAssertNotNil(sut?.navigationController?.navigationBar.topItem?.rightBarButtonItem)
        tapBarButton((sut?.navigationController?.navigationBar.topItem?.rightBarButtonItem)!)
    }
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut?.prepTimeLabel, "prepTimeLabel")
        XCTAssertNotNil(sut?.cocktailImageView, "cocktailImageView")
        XCTAssertNotNil(sut?.longDescriptionLabel, "longDescriptionLabel")
        XCTAssertNotNil(sut?.tableView , "tableView")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    

}
