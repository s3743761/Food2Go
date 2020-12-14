//
//  Food2GoUITests.swift
//  Food2GoUITests
//
//  Created by Liam Hector on 29/7/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import XCTest
var app: XCUIApplication!

class Food2GoUITests: XCTestCase {
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
//    func makeSUT() -> ArtistDetailViewController {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let sut = storyboard.instantiateViewController(identifier: "ArtistDetailViewController") as! ArtistDetailViewController
//        sut.presenter = presenter
//        sut.loadViewIfNeeded()
//        return sut
//    }

    func testHomeTabBarExists() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Home"].tap()
    }
    
    func testFavouritesTabBarExists() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Favorites"].tap()
    }
    
    func testExploreTabBarExists() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Explore"].tap()
    }
    
    func testProfileTabBarExists() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Profile"].tap()
    }
    
    func testStudentsTabBarExists() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Students"].tap()
    }
    
    func testExplore() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Explore"].tap()
        let location = app.textFields["Search For Location"]
        location.tap()
        location.typeText("Melbourne")
        app.buttons["Search"].tap()
    }
    
    
    

}
