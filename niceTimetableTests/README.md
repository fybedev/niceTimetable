# niceTimetableTests

This directory contains unit tests for the niceTimetable iOS app.

## Test Files

- `SchoolModelsTests.swift` - Tests for the School and SchoolClass models, including their Codable conformance and ID generation
- `PreferencesManagerTests.swift` - Tests for the PreferencesManager service, including saving/loading preferences and alias management

## Adding the Test Target to Xcode

The test files are ready, but you need to add them to your Xcode project as a test target. Here's how:

### Option 1: Using Xcode GUI (Recommended)

1. Open `niceTimetable.xcodeproj` in Xcode
2. Go to File → New → Target...
3. Select "Unit Testing Bundle" under the iOS tab
4. Name it "niceTimetableTests"
5. Product Name: `niceTimetableTests`
6. Organization Identifier: Same as your app
7. Click Finish
8. When prompted to add a bridging header, click "Don't Create"
9. Delete the default test file that Xcode creates
10. Right-click on the niceTimetableTests group in the project navigator
11. Select "Add Files to niceTimetableTests..."
12. Navigate to the `niceTimetableTests` folder and select all `.swift` files
13. Make sure "Copy items if needed" is UNCHECKED
14. Make sure "niceTimetableTests" target is checked
15. Click Add
16. In the niceTimetableTests target settings:
    - Go to Build Phases → Target Dependencies
    - Add "niceTimetable" as a dependency
    - Go to Build Settings → Search for "Host Application"
    - Set it to "niceTimetable"

### Option 2: Using Command Line

After adding the test target via Xcode, you can run tests from the command line:

```bash
# Run all tests
xcodebuild test \
  -project niceTimetable.xcodeproj \
  -scheme niceTimetable \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'

# Run with code coverage
xcodebuild test \
  -project niceTimetable.xcodeproj \
  -scheme niceTimetable \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest' \
  -enableCodeCoverage YES
```

## Running Tests

Once the test target is added:

1. **In Xcode**: Press `Cmd+U` or go to Product → Test
2. **In Terminal**: Use the xcodebuild commands shown above
3. **On GitHub Actions**: The CI workflow will automatically run tests on every push and pull request

## Adding New Tests

1. Create a new Swift file in the `niceTimetableTests` directory
2. Import XCTest and the app module: `@testable import niceTimetable`
3. Create a test class that inherits from `XCTestCase`
4. Add test methods (they must start with `test`)
5. Add the file to the niceTimetableTests target in Xcode

Example:

```swift
import XCTest
@testable import niceTimetable

final class MyNewTests: XCTestCase {
    func testSomething() {
        // Your test code here
        XCTAssertTrue(true)
    }
}
```

## GitHub Actions CI

The repository includes a GitHub Actions workflow (`.github/workflows/ios-ci.yml`) that:
- Builds the project on every push and pull request
- Runs all tests (once the test target is added)
- Uploads test results as artifacts
- Provides code coverage information

The workflow will gracefully handle the case where tests haven't been added yet, allowing the build to succeed.
