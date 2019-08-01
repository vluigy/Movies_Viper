//
//  MovieListCollectionTest.swift
//  Movies_ViperUITests
//
//  Created by Luigy Vega on 8/1/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import XCTest
@testable import Movies_Viper

class MovieListCollectionTest: XCTestCase {

    var viewController: MoviesListViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let storyboard = UIStoryboard.init(name: "Movies", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "MoviesList") as? MoviesListViewController
        viewController.loadViewIfNeeded()
        
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
    }

    func test_ViewShow() {
        XCTAssertNotNil(viewController, "View loaded")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
