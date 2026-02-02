//
//  PreferencesManagerTests.swift
//  niceTimetableTests
//
//  Created for niceTimetable
//

import XCTest
@testable import niceTimetable

final class PreferencesManagerTests: XCTestCase {
    
    var preferencesManager: PreferencesManager!
    
    override func setUp() {
        super.setUp()
        preferencesManager = PreferencesManager.shared
        
        // Clear preferences before each test
        preferencesManager.schoolType = nil
        preferencesManager.schoolCode = nil
        preferencesManager.schoolName = nil
        preferencesManager.officeCode = nil
        preferencesManager.grade = nil
        preferencesManager.className = nil
    }
    
    override func tearDown() {
        preferencesManager = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Test that PreferencesManager initializes properly
        XCTAssertNotNil(preferencesManager)
    }
    
    func testSaveAndLoadSchoolInfo() {
        // Save school information
        preferencesManager.schoolType = "고등학교"
        preferencesManager.schoolCode = "TEST001"
        preferencesManager.schoolName = "테스트 고등학교"
        preferencesManager.officeCode = "B10"
        
        // Verify the school info was saved
        XCTAssertEqual(preferencesManager.schoolType, "고등학교")
        XCTAssertEqual(preferencesManager.schoolCode, "TEST001")
        XCTAssertEqual(preferencesManager.schoolName, "테스트 고등학교")
        XCTAssertEqual(preferencesManager.officeCode, "B10")
    }
    
    func testSaveAndLoadClassInfo() {
        // Save class information
        preferencesManager.grade = "2"
        preferencesManager.className = "3"
        
        // Verify the class info was saved
        XCTAssertEqual(preferencesManager.grade, "2")
        XCTAssertEqual(preferencesManager.className, "3")
    }
    
    func testLoadNonExistentData() {
        // Clear any existing data
        preferencesManager.schoolType = nil
        preferencesManager.schoolCode = nil
        preferencesManager.grade = nil
        preferencesManager.className = nil
        
        // Should return nil for non-existent data
        XCTAssertNil(preferencesManager.schoolType)
        XCTAssertNil(preferencesManager.schoolCode)
        XCTAssertNil(preferencesManager.grade)
        XCTAssertNil(preferencesManager.className)
    }
    
    func testAliasManagement() {
        // Test setting an alias
        preferencesManager.setAlias(for: "수학", normal: "수학시간", compact: "수학")
        
        let aliases = preferencesManager.aliases
        XCTAssertNotNil(aliases["수학"])
        XCTAssertEqual(aliases["수학"]?.normal, "수학시간")
        XCTAssertEqual(aliases["수학"]?.compact, "수학")
        
        // Test removing an alias
        preferencesManager.removeAlias(for: "수학")
        let updatedAliases = preferencesManager.aliases
        XCTAssertNil(updatedAliases["수학"])
    }
}
