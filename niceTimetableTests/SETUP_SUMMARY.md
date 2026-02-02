# Test Setup Summary

This document summarizes the test setup for the niceTimetable iOS app.

## What Was Created

### 1. Test Directory: `niceTimetableTests/`

Created a new test directory containing:

#### Test Files:
- **SchoolModelsTests.swift** - Unit tests for the School and SchoolClass models
  - Tests for Identifiable conformance
  - Tests for Codable (JSON encoding/decoding)
  - Tests for String extension (`firstMeaningfulCharacter`)
  
- **PreferencesManagerTests.swift** - Unit tests for the PreferencesManager service
  - Tests for saving and loading school information
  - Tests for saving and loading class information
  - Tests for alias management (set, get, remove)
  - Tests for handling non-existent data

#### Supporting Files:
- **Info.plist** - Required configuration file for the test bundle
- **README.md** - Comprehensive documentation on running and adding tests

### 2. Xcode Project Configuration

Modified `niceTimetable.xcodeproj/project.pbxproj` to:
- Add a new test target named "niceTimetableTests"
- Configure the test target with proper bundle identifier and settings
- Link test files to the test target
- Set up dependency on the main niceTimetable target

Modified `niceTimetable.xcodeproj/xcshareddata/xcschemes/niceTimetable.xcscheme` to:
- Include the niceTimetableTests target in the Test action
- Enable tests to run with `Cmd+U` in Xcode or via xcodebuild

### 3. GitHub Actions CI Workflow

Created `.github/workflows/ios-ci.yml` with:
- Automatic builds on push and pull requests to main/master branches
- Manual trigger support via workflow_dispatch
- Building the iOS app for simulator
- Running unit tests with code coverage
- Uploading test results as artifacts
- Graceful handling of missing test configuration

## Test Coverage

The tests cover:

### Models (`SchoolModels.swift`)
- ✅ School ID generation (should match schoolCode)
- ✅ School encoding/decoding (Codable conformance)
- ✅ SchoolClass ID generation (grade + className)
- ✅ SchoolClass encoding/decoding
- ✅ String extension for finding first meaningful character

### Services (`PreferencesManager.swift`)
- ✅ Saving and retrieving school information (type, code, name, officeCode)
- ✅ Saving and retrieving class information (grade, className)
- ✅ Setting and retrieving subject aliases
- ✅ Removing aliases
- ✅ Handling nil/empty values

## Running Tests

### In Xcode
1. Open `niceTimetable.xcodeproj`
2. Press `Cmd+U` to run all tests
3. View results in the Test Navigator (`Cmd+6`)

### Via Command Line
```bash
xcodebuild test \
  -project niceTimetable.xcodeproj \
  -scheme niceTimetable \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'
```

### In GitHub Actions
Tests run automatically on:
- Every push to main/master
- Every pull request to main/master
- Manual workflow dispatch

## GitHub Actions Workflow Features

The CI workflow (`ios-ci.yml`) includes:

1. **Build Step**: Compiles the iOS app for simulator
2. **Test Step**: Runs all unit tests with error handling
3. **Artifact Upload**: Saves test results (`.xcresult` files) for 30 days
4. **Smart Exit Handling**: 
   - Exit code 0: Tests passed ✅
   - Exit code 65: No tests found (expected before target added) ⚠️
   - Other codes: Tests failed ❌

## Next Steps

### Adding More Tests
1. Create a new `.swift` file in `niceTimetableTests/`
2. Import XCTest and the app: `@testable import niceTimetable`
3. Create a class inheriting from `XCTestCase`
4. Add test methods (must start with `test`)
5. The file should automatically be included in the test target

### Example Test Template
```swift
import XCTest
@testable import niceTimetable

final class MyNewTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Setup code
    }
    
    override func tearDown() {
        // Cleanup code
        super.tearDown()
    }
    
    func testExample() {
        // Arrange
        let expected = "value"
        
        // Act
        let actual = functionToTest()
        
        // Assert
        XCTAssertEqual(actual, expected)
    }
}
```

### Recommended Areas for Additional Testing
- APIClient.swift - Network request handling
- CacheManager.swift - Caching logic
- TimetableViewModel.swift - View model logic
- SchoolSearchViewModel.swift - Search functionality
- Model extensions in SchoolModels.swift (toSchools(), toClasses())

## Configuration Details

### Test Target Settings
- **Product Name**: niceTimetableTests
- **Bundle Identifier**: dev.jongwoo.niceTimetableTests
- **Host Application**: niceTimetable
- **iOS Deployment Target**: 17.0
- **Swift Version**: 5.0

### GitHub Actions Runner
- **OS**: macOS 14 (Ventura)
- **Xcode**: Latest available on the runner
- **Test Destination**: iPhone 15 Simulator, latest iOS

## Troubleshooting

### Tests Not Running
- Verify test target is added to the scheme
- Check that test files are in the test target membership
- Ensure the test target depends on the main app target

### Build Failures in CI
- Check the GitHub Actions logs for specific error messages
- Ensure code signing is disabled for simulator builds
- Verify the simulator name and iOS version are available

### Test Failures
- Run tests locally first to debug
- Check test output in Xcode Test Navigator
- Use `print()` statements or breakpoints for debugging
- Review test assertions and expected values

## Benefits

✅ **Automated Testing**: Tests run on every code change
✅ **Early Bug Detection**: Catch issues before they reach production
✅ **Code Confidence**: Make changes knowing tests will catch regressions
✅ **Documentation**: Tests serve as usage examples
✅ **CI/CD Ready**: Foundation for continuous integration and deployment

## Files Created/Modified

### New Files
- `.github/workflows/ios-ci.yml`
- `niceTimetableTests/SchoolModelsTests.swift`
- `niceTimetableTests/PreferencesManagerTests.swift`
- `niceTimetableTests/Info.plist`
- `niceTimetableTests/README.md`
- `niceTimetableTests/SETUP_SUMMARY.md` (this file)

### Modified Files
- `niceTimetable.xcodeproj/project.pbxproj` - Added test target
- `niceTimetable.xcodeproj/xcshareddata/xcschemes/niceTimetable.xcscheme` - Added test configuration

## Resources

- [XCTest Documentation](https://developer.apple.com/documentation/xctest)
- [GitHub Actions for iOS](https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-swift)
- [Xcode Test Plans](https://developer.apple.com/documentation/xcode/organizing-tests-to-improve-feedback)
