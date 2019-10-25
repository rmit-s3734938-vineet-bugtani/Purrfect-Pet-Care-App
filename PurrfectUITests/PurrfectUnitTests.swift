//
//  PurrfectUnittests.swift
//  PurrfectUITests
//
//  Created by Vineet Bugtani on 6/10/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import XCTest


class PurrfectUnitTests: XCTestCase {
    
    private var catsManager: CatsManager?
    
    override func setUp() {
        super.setUp()
        catsManager = CatsManager.shared
        XCTAssertEqual(true, true)
    }
}
