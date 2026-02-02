//
//  SchoolModelsTests.swift
//  niceTimetableTests
//
//  Created for niceTimetable
//

import XCTest
@testable import niceTimetable

final class SchoolModelsTests: XCTestCase {
    
    // MARK: - School Tests
    
    func testSchoolIdentifiable() {
        let school = School(
            schoolType: "고등학교",
            schoolCode: "7001234",
            schoolName: "테스트 고등학교",
            officeCode: "B10",
            officeName: "서울특별시교육청",
            address: "서울특별시 강남구",
            type: "고등학교"
        )
        
        XCTAssertEqual(school.id, "7001234", "School ID should match schoolCode")
    }
    
    func testSchoolCodable() throws {
        let school = School(
            schoolType: "고등학교",
            schoolCode: "7001234",
            schoolName: "테스트 고등학교",
            officeCode: "B10",
            officeName: "서울특별시교육청",
            address: "서울특별시 강남구",
            type: "고등학교"
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(school)
        
        let decoder = JSONDecoder()
        let decodedSchool = try decoder.decode(School.self, from: data)
        
        XCTAssertEqual(decodedSchool.schoolCode, school.schoolCode)
        XCTAssertEqual(decodedSchool.schoolName, school.schoolName)
        XCTAssertEqual(decodedSchool.officeCode, school.officeCode)
    }
    
    // MARK: - SchoolClass Tests
    
    func testSchoolClassIdentifiable() {
        let schoolClass = SchoolClass(grade: "1", className: "3")
        XCTAssertEqual(schoolClass.id, "13", "SchoolClass ID should be grade + className")
    }
    
    func testSchoolClassCodable() throws {
        let schoolClass = SchoolClass(grade: "2", className: "5")
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(schoolClass)
        
        let decoder = JSONDecoder()
        let decodedClass = try decoder.decode(SchoolClass.self, from: data)
        
        XCTAssertEqual(decodedClass.grade, schoolClass.grade)
        XCTAssertEqual(decodedClass.className, schoolClass.className)
    }
    
    // MARK: - String Extension Tests
    
    func testFirstMeaningfulCharacter() {
        XCTAssertEqual("abc".firstMeaningfulCharacter, "a")
        XCTAssertEqual("123".firstMeaningfulCharacter, "1")
        XCTAssertEqual("!@#abc".firstMeaningfulCharacter, "a")
        XCTAssertEqual("한글".firstMeaningfulCharacter, "한")
        XCTAssertNil("".firstMeaningfulCharacter)
    }
    
    func testFirstMeaningfulCharacterWithSpecialChars() {
        XCTAssertEqual("___test".firstMeaningfulCharacter, "t")
        XCTAssertEqual("...123".firstMeaningfulCharacter, "1")
    }
}
