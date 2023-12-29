//
//  CocktailViewControllerTests.swift
//  CocktailBookTests
//
//  Created by Arun Kumar on 12/12/2023.
//

import XCTest
@testable import CocktailBook

final class CocktailViewControllerTests: XCTestCase {

    var sut: CocktailViewController?
    var mockCocktailAPI: MockCocktailsAPI?
    var fakeUserDefaults: FakeUserDefaultsManager?
    
    override func setUp() {
        super.setUp()
        sut = CocktailViewController()
        mockCocktailAPI = MockCocktailsAPI()
        fakeUserDefaults = FakeUserDefaultsManager()
    }
    
    func test_fetchingCocktailsData(){
        let mockCocktailAPI = MockCocktailsAPI()
        sut?.viewModel = CocktailsViewModel(cocktailService: mockCocktailAPI)
        sut?.loadViewIfNeeded()
        XCTAssertEqual(mockCocktailAPI.dataTaskCallCount, 1, "call count")
    }
    
    func test_fetchingCocktailsData_withFailure_callCountShouldBe_0(){
        
        sut?.viewModel = CocktailsViewModel(cocktailService: FakeCocktailsAPI(withFailure: .count(3)))
        sut?.loadViewIfNeeded()
        XCTAssertEqual(mockCocktailAPI?.dataTaskCallCount, 0, "call count")
    }

    func test_outlets_shouldBeConnected() {
        sut?.loadViewIfNeeded()
        XCTAssertNotNil(sut?.filterSegment, "filterSegment")
        XCTAssertNotNil(sut?.tableView, "tableView")
    }
    
    func test_withEmptyUserDefaults_shouldShow0InFavourites() {
        
        sut?.viewModel = CocktailsViewModel(cocktailService: mockCocktailAPI!)
        sut?.loadViewIfNeeded()
        XCTAssertEqual(sut?.viewModel.favourites.count, 0)
    }
    
    func test_withAValue_shouldShow_1_InFavourites() {
        fakeUserDefaults?.cocktails = ["lemon"]
        sut?.viewModel = CocktailsViewModel(cocktailService: mockCocktailAPI!)
        sut?.viewModel.userDefaultsManager = fakeUserDefaults!
        XCTAssertNotNil(sut?.viewModel.addToFavourites(identifier: "lemon"))
        sut?.loadViewIfNeeded()
        XCTAssertEqual(sut?.viewModel.favourites.count, 1)
    }
    
    func test_with2Value_shouldShow_3_InFavourites() {
        fakeUserDefaults?.cocktails = ["apple", "Mango"]
        sut?.viewModel = CocktailsViewModel(cocktailService: mockCocktailAPI!)
        sut?.viewModel.userDefaultsManager = fakeUserDefaults!
        XCTAssertNotNil(sut?.viewModel.addToFavourites(identifier: "mango"))
        sut?.loadViewIfNeeded()
        XCTAssertEqual(sut?.viewModel.favourites.count, 3)
    }
    
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
