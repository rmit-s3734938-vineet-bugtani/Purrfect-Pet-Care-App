//
//  PurrfectUITests.swift
//  PurrfectUITests
//
//  Created by Sumit Sitlani on 19/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import XCTest

class PurrfectUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
    func testIncompleteInputByUser() // To test if missing input field generates an alert
    {
        
        let app = XCUIApplication()
        app.tabBars.buttons["Cats"].tap()
        let addButton = app.navigationBars["Your Cats"]
        XCTAssertTrue(addButton.exists)
        addButton.buttons["Add"].tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"A New Friend ").children(matching: .other).element.swipeUp()
        scrollViewsQuery.otherElements.buttons["Done"].tap()
        let invalidInputAlert = app.alerts["Oops, you forgot something..."]
        XCTAssertTrue(invalidInputAlert.exists)
        invalidInputAlert.buttons["Okay"].tap()
        
    }
    
    func testnetwork()
    {
        
        let app = XCUIApplication()
        let tabBar = app.tabBars.buttons["Breeds"]
        XCTAssertTrue(tabBar.exists)
        tabBar.tap()
        
        let tapToSelectABreedTextField = app.textFields["Tap to select a breed"]
        XCTAssertTrue(tapToSelectABreedTextField.exists)
        tapToSelectABreedTextField.tap()
        
        let doneButton = app.toolbars["Toolbar"].buttons["Done"]
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()
        tapToSelectABreedTextField.tap()
        let picker = app/*@START_MENU_TOKEN@*/.pickers.pickerWheels["Abyssinian"]/*[[".pickers.pickerWheels[\"Abyssinian\"]",".pickerWheels[\"Abyssinian\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        picker.tap()
        XCTAssertTrue(picker.exists)
        doneButton.tap()
        let originLabel = app.staticTexts["Origin: Egypt"]
        let tempLabel = app.staticTexts["Temperament: Active, Energetic, Independent, Intelligent, Gentle"]
        let lifespanLabel = app.staticTexts["Lifespan: 14 - 15 years"]
        XCTAssertTrue(originLabel.exists)
        XCTAssertTrue(tempLabel.exists)
        XCTAssertTrue(lifespanLabel.exists)
    }
    
    func testHomeScreen() {
        
        let app = XCUIApplication()
        let homeTabBar = app.tabBars.buttons["Owner"]
        XCTAssertTrue(homeTabBar.exists)
        homeTabBar.tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let ownerNameLabel = elementsQuery.staticTexts["Nelly Niawati"]
        let ownerDescLabel = elementsQuery.staticTexts["Single, but I don't feel that way cause I'm married to my job and have two cats to care for."]
        XCTAssertTrue(ownerNameLabel.exists)
        XCTAssertTrue(ownerDescLabel.exists)
        
        let element2 = scrollViewsQuery.children(matching: .other).element
        let picker = element2.children(matching: .other).element
        XCTAssertTrue(picker.exists)
        picker.children(matching: .other).element(boundBy: 0).tap()
        elementsQuery.staticTexts["Don't forget..."].tap()
        picker.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .textField).element.tap()
        
        let doneButton = app.toolbars["Toolbar"].buttons["Done"]
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()
        
        picker.children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .textField).element.tap()
        doneButton.tap()
        
       picker.children(matching: .other).element(boundBy: 3).children(matching: .other).element.children(matching: .textField).element.tap()
        doneButton.tap()
        
        let textView = element2.children(matching: .textView).element
        XCTAssertTrue(textView.exists)
        textView.swipeUp()
    
    }
    
    func testNavigationThroughApp() {
        
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        let ownerButton = tabBarsQuery.buttons["Owner"]
        let catsButton = tabBarsQuery.buttons["Cats"]
       //let cat1 = app.tables/*@START_MENU_TOKEN@*/.cells.staticTexts["This is a naughty one"]/*[[".cells.staticTexts[\"This is a naughty one\"]",".staticTexts[\"This is a naughty one\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        //let catNavigationButton = app.navigationBars["Purrfect.DetailView"].buttons["Your Cats"]
        let breedsButton = tabBarsQuery.buttons["Breeds"]
        let faceDetectionButton = tabBarsQuery.buttons["Face Recognition"]
        let authorButton = tabBarsQuery.buttons["Student ids"]
        XCTAssertTrue(ownerButton.exists)
        ownerButton.tap()
        XCTAssertTrue(catsButton.exists)
        catsButton.tap()
        //XCTAssertTrue(catNavigationButton.exists)
        //catNavigationButton.tap()
        XCTAssertTrue(breedsButton.exists)
        breedsButton.tap()
        XCTAssertTrue(faceDetectionButton.exists)
        faceDetectionButton.tap()
        XCTAssertTrue(authorButton.exists)
        authorButton.tap()
    }

}
