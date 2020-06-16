<p align="center">
  <img src="/Images/mockingbird-hero-image.png" alt="Mockingbird - Swift Mocking Framework" width="350">
</p>

<p align="center">
  <a href="#installation"><img src="https://img.shields.io/badge/package-cocoapods%20%7C%20carthage%20%7C%20spm-4BC51D.svg" alt="Package managers"></a>
  <a href="/andrewchang-bird/mockingbird/blob/add-readme-logo/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
  <a href="https://slofile.com/slack/birdopensource" rel="nofollow"><img src="https://img.shields.io/badge/slack-join%20channel-A417A6.svg" alt="Slack"></a>
</p>

```swift
// Mocking
let bird = mock(Bird.self)

// Stubbing
given(bird.getName()) ~> "Ryan"

// Verification
verify(bird.fly()).wasCalled()
```

## What is Mockingbird?

Mockingbird is a Swift mocking framework that lets you throw away your hand-written mocks and write clean, readable tests.

- **Expansive coverage of Swift language features**
  - Mock classes and protocols in a single line of code
  - Support for generics, inheritance, static members, nested classes, type aliasing, etc.
- **Seamless integration with Xcode projects**
  - Automatic discovery of source and dependency files
  - Handling of external types from third-party libraries
- **Convenient testing API**
  - Clear stubbing and verification error messages
  - Support for asynchronous code, in order verification, default return value stubbing, etc.

### Under the Hood

Mockingbird consists of two main components: the _generator_ and the _testing framework_. The generator creates mocks before each test bundle compilation by implementing protocols and subclassing classes, while the testing framework hooks into the generated code and provides APIs for mocking, stubbing, and verification.

A key design consideration was performance. Mockingbird runs an optimized parser built on SwiftSyntax and SourceKit that is [~30-40x faster](https://github.com/birdrides/mockingbird/wiki/Performance) than existing frameworks and supports a [broad range](https://github.com/birdrides/mockingbird/wiki/Elephant-in-the-Room#other-third-party-mocking-frameworks) of complex Swift features like generics and type qualification.

### A Simple Example

```swift
protocol Bird {
  var canFly: Bool { get }
  func fly()
}

class Tree {
  let bird: Bird
  
  init(with bird: Bird) {
    self.bird = bird
  }
  
  func shake() {
    guard bird.canFly else { return }
    bird.fly()
  }
}

func testShakingTreeCausesBirdToFly() {
  // Given a tree with a bird that can fly
  let bird = mock(Bird.self)
  let tree = Tree(with: bird)
  given(bird.getCanFly()) ~> true
  
  // When the tree is shaken
  tree.shake()
  
  // Then the bird flies away
  verify(bird.fly()).wasCalled()
}
```

## Installation

<details><summary><b>CocoaPods</b></summary>

Add the framework to a test target in your `Podfile`, making sure to include the `use_frameworks!` option.

```ruby
target 'MyAppTests' do
  use_frameworks!
  pod 'MockingbirdFramework', '~> 0.13'
end
```

Initialize the pod and install the CLI.

```bash
$ pod install
$ (cd Pods/MockingbirdFramework && make install-prebuilt)
```

Finally, configure your test target to start generating mocks before each test bundle compilation. List all source targets that should be mocked. You can also [set up targets manually](https://github.com/birdrides/mockingbird/wiki/Manual-Setup).

```bash
$ mockingbird install --target MyAppTests --sources MyApp MyLibrary1 MyLibrary2
```

Have questions or issues?

- Join the [Slack channel](https://slofile.com/slack/birdopensource)
- Search the [troubleshooting guide](https://github.com/birdrides/mockingbird/wiki/Troubleshooting)
- Check out the [CocoaPods tutorial + example project](/Examples/iOSMockingbirdExample-CocoaPods)

</details>

<details><summary><b>Carthage</b></summary>

Add the framework to your `Cartfile`.

```
github "birdrides/mockingbird" ~> 0.13
```

Build the framework with Carthage, [link it to your test target](https://github.com/birdrides/mockingbird/wiki/Linking-Test-Targets), and install the CLI.

```bash
$ carthage update
$ (cd Carthage/Checkouts/mockingbird && make install-prebuilt)
```

Finally, configure your test target to start generating mocks before each test bundle compilation. List all source targets that should be mocked. You can also [set up targets manually](https://github.com/birdrides/mockingbird/wiki/Manual-Setup).

```bash
$ mockingbird install --target MyAppTests --sources MyApp MyLibrary1 MyLibrary2
```

Have questions or issues?

- Join the [Slack channel](https://slofile.com/slack/birdopensource)
- Search the [troubleshooting guide](https://github.com/birdrides/mockingbird/wiki/Troubleshooting)
- Check out the [Carthage tutorial + example project](/Examples/iOSMockingbirdExample-Carthage)

</details>

<details><summary><b>Swift Package Manager</b></summary>

Add the framework as a package and test target dependency in your project’s `Package.swift` manifest file.

```swift
let package = Package(
  name: "MyPackage",
  dependencies: [
    .package(url: "https://github.com/birdrides/mockingbird.git", from: "0.13.0"),
  ],
  targets: [
    .testTarget(name: "MyPackageTests", dependencies: ["Mockingbird"]),
  ]
)
```

Initialize the package dependency and install the CLI.

```bash
$ xcodebuild -resolvePackageDependencies
$ DERIVED_DATA=$(xcodebuild -showBuildSettings | pcregrep -o1 'OBJROOT = (/.*)/Build')
$ (cd "${DERIVED_DATA}/SourcePackages/checkouts/mockingbird" && make install-prebuilt)
```

Finally, configure your test target to start generating mocks before each test bundle compilation. List all source targets that should be mocked. You can also [set up targets manually](https://github.com/birdrides/mockingbird/wiki/Manual-Setup).

```bash
$ mockingbird install --target MyPackageTests --sources MyPackage MyLibrary1 MyLibrary2
```

Have questions or issues?

- Join the [Slack channel](https://slofile.com/slack/birdopensource)
- Search the [troubleshooting guide](https://github.com/birdrides/mockingbird/wiki/Troubleshooting)
- Check out the [Swift Package Manager tutorial + example project](/Examples/iOSMockingbirdExample-SPM)

</details>

## Usage

1. [Mocking](#1-mocking)
2. [Stubbing](#2-stubbing)
3. [Verification](#3-verification)
4. [Argument Matching](#4-argument-matching)
5. [Miscellaneous](#5-miscellaneous)

### 1. Mocking

Mock types can be passed in place of the original type and are suffixed with `Mock`. Avoid explicitly coercing mock types into their supertype, as this breaks stubbing and verification.

#### Mock Protocols

Note that the initialized mock type is `BirdMock` instead of `Bird`.

```swift
let bird: BirdMock = mock(Bird.self)  // The concrete type is `BirdMock`
let inferredBird = mock(Bird.self)    // but type inference also works
```

#### Mock Classes

Initialize concrete class mocks using the `initialize` method. Keep in mind that class mocks rely on subclassing which has certain limitations, so consider using protocol mocks whenever possible.

```swift
class Bird {
  let name: String
  init(named name: String) { self.name = name }
}
let bird = mock(Bird.self).initialize(named: "Ryan")
```

#### Reset Mocks

It’s possible to reset mocks and clear specific configurations during test runs.

```swift
reset(bird)                    // Reset everything
clearStubs(on: bird)           // Only remove stubs
clearDefaultValues(on: bird)   // Only remove default values
clearInvocations(on: bird)     // Only remove recorded invocations
```

### 2. Stubbing

Stubbing allows you to define custom behavior for mocks to perform.

```swift
given(bird.getName()) ~> "Ryan"
```

Use a closure to implement stubs that contain logic, interact with arguments, or throw errors.

```swift
given(bird.fly()) ~> { throw BirdError() }

given(bird.eat(any(), callback: any())) ~> { fruit, callback in
  callback(fruit.size / 2)
}
```

#### Stub Methods with Parameters

[Match exact or wildcard argument values](#4-argument-matching) when stubbing methods with parameters. Stubs added later have a higher precedence, so add stubs with specific matchers last.

```swift
given(bird.canChirp(volume: any())) ~> false    // Matches any volume
given(bird.canChirp(volume: notNil())) ~> true  // Matches any non-nil volume
given(bird.canChirp(volume: 10)) ~> false       // Matches volume = 10
```

#### Stub Properties

Stub properties with their getter and setter methods.

```swift
given(bird.getName()) ~> "Ryan"
given(bird.setName(any())) ~> { print($0) }
```

Getters can be stubbed to automatically save and return values.

```swift
given(bird.getName()) ~> lastSetValue(initial: "Ryan")
bird.name = "Sterling"
print(bird.name)  // Prints "Sterling"
```

#### Relaxed Stubs with Default Values

Mocks are strict by default, meaning that calls to unstubbed methods will trigger a test failure. Methods returning `Void` do not need to be stubbed in strict mode.

```swift
let bird = mock(Bird.self)
print(bird.name)  // Fails because `bird.getName()` is not stubbed
bird.fly()        // Okay because `fly()` has a `Void` return type
```

To return default values for unstubbed methods, use a `ValueProvider` with the initialized mock. Mockingbird provides preset value providers which are guaranteed to be backwards compatible, such as `.standardProvider`.

```swift
useDefaultValues(from: .standardProvider, on: bird)
print(bird.name)  // Prints ""
```

Create custom value providers by registering values for types. 

```swift
var valueProvider = ValueProvider(from: .standardProvider)
valueProvider.register("Ryan", for: String.self)
useDefaultValues(from: valueProvider, on: bird)
print(bird.name)  // Prints "Ryan"
```

Values from concrete stubs always have a higher precedence than default values.

```swift
given(bird.getName()) ~> "Ryan"
print(bird.name)  // Prints "Ryan"

useDefaultValues(from: .standardProvider, on: bird)
print(bird.name)  // Still prints "Ryan"
```

Provide “wildcard” instances for generic types by conforming the base type to `Providable` and registering the type.

```swift
extension Array: Providable {
  public static func createInstance() -> Self? {
    return Array()
  }
}

// An empty array is registered for all specialized `Array` types
valueProvider.registerType(Array<Any>.self)
```

#### Stub a Sequence of Values

Methods that return a different value each time can be stubbed with a sequence of values. The last value will be used for all subsequent invocations.

```swift
given(bird.getName()) ~> sequence(of: "Ryan", "Sterling")
print(bird.name)  // Prints "Ryan"
print(bird.name)  // Prints "Sterling"
print(bird.name)  // Prints "Sterling"
```

It’s also possible to stub a sequence of lazily-computed values using closures. 

```swift
given(bird.getName()) ~> sequence(of: {
  return "Ryan"
}, {
  return "Sterling"
}, {
  return Bool.random() ? "Ryan" : "Sterling"
})
```

### 3. Verification

Verification lets you assert that a mock received a particular invocation during its lifetime.

```swift
verify(bird.fly()).wasCalled()
```

Verifying doesn’t remove recorded invocations, so it’s safe to call `verify` multiple times.

```swift
verify(bird.fly()).wasCalled()  // If this succeeds...
verify(bird.fly()).wasCalled()  // ...this also succeeds
```

#### Verify Methods with Parameters

[Match exact or wildcard argument values](#4-argument-matching) when verifying methods with parameters.

```swift
verify(bird.canChirp(volume: any())).wasCalled()     // Called with any volume
verify(bird.canChirp(volume: notNil())).wasCalled()  // Called with any non-nil volume
verify(bird.canChirp(volume: 10)).wasCalled()        // Called with volume = 10
```

#### Verify Properties

Verify property invocations using their getter and setter methods.

```swift
verify(bird.getName()).wasCalled()
verify(bird.setName(any())).wasCalled()
```

#### Verify the Number of Invocations

It’s possible to verify that an invocation was called a specific number of times with a count matcher.

```swift
verify(bird.fly()).wasNeverCalled()            // n = 0
verify(bird.fly()).wasCalled(exactly(10))      // n = 10
verify(bird.fly()).wasCalled(atLeast(10))      // n ≥ 10
verify(bird.fly()).wasCalled(atMost(10))       // n ≤ 10
verify(bird.fly()).wasCalled(between(5...10))  // 5 ≤ n ≤ 10
```

Count matchers also support chaining and negation using logical operators.

```swift
verify(bird.fly()).wasCalled(not(exactly(10)))           // n ≠ 10
verify(bird.fly()).wasCalled(exactly(10).or(atMost(5)))  // n = 10 || n ≤ 5
```

#### Argument Capturing

An argument captor extracts received argument values which can be used in other parts of the test.

```swift
let bird = mock(Bird.self)
bird.name = "Ryan"

let nameCaptor = ArgumentCaptor<String>()
verify(bird.setName(nameCaptor.matcher)).wasCalled()

print(nameCaptor.value)  // Prints "Ryan"
```

#### In Order Verification

Enforce the relative order of invocations with an `inOrder` verification block.

```swift
// Verify that `fly` was called before `chirp`
inOrder {
  verify(bird.fly()).wasCalled()
  verify(bird.chirp()).wasCalled()
}
```

Pass options to `inOrder` verification blocks for stricter checks with additional invariants.

```swift
inOrder(with: .noInvocationsAfter) {
  verify(bird.fly()).wasCalled()
  verify(bird.chirp()).wasCalled()
}
```

#### Asynchronous Verification

Mocked methods that are invoked asynchronously can be verified using an `eventually` block which returns an `XCTestExpectation`. 

```swift
DispatchQueue.main.async {
  Tree(with: bird).shake()
}

let expectation =
  eventually {
    verify(bird.fly()).wasCalled()
    verify(bird.chirp()).wasCalled()
  }

wait(for: [expectation], timeout: 1.0)
```

#### Verify Methods Overloaded by Return Type

Specify the expected return type to disambiguate overloaded methods.

```swift
protocol Bird {
  func getMessage<T>() -> T    // Overloaded generically
  func getMessage() -> String  // Overloaded explicitly
  func getMessage() -> Data
}

verify(bird.getMessage()).returning(String.self).wasCalled()
```

### 4. Argument Matching

Argument matching allows you to handle parameterized methods for stubbing or verification.

#### Match Exact Values

Value types that explicitly conform to `Equatable` work out of the box. Note that structs able to synthesize `Equatable` conformance must still explicitly declare conformance.

```swift
struct Fruit: Equatable {
  let size: Int
}

verify(bird.eat(Fruit(size: 42))).wasCalled()
verify(bird.setName("Ryan")).wasCalled()
```

Class instances can be safely compared by reference.

```swift
class Tree {
  init(with bird: Bird) {
    bird.home = self
  }
}

let tree = Tree(with: bird)
verify(bird.setHome(tree)).wasCalled()
```

#### Match Any Value and Non-Equatable Types

Argument matchers allow wildcard and custom matching of arguments that don’t conform to `Equatable`.

```swift
any()                    // Matches any value
any(of: 1, 2, 3)         // Matches any value in {1, 2, 3}
any(where: { $0 > 42 })  // Matches any number greater than 42
notNil()                 // Matches any non-nil value
```

For methods overloaded by parameter type (such as with generics), using a matcher may cause ambiguity for the compiler. You can help the compiler by specifying an explicit type in the matcher.

```swift
any(Int.self)
any(Int.self, of: 1, 2, 3)
any(Int.self, where: { $0 > 42 })
notNil(String?.self)
```

You can also match elements or keys within collection types.

```swift
any(containing: 1, 2, 3)  // Matches any collection with values {1, 2, 3}
any(keys: "a", "b", "c")  // Matches any dictionary with keys {"a", "b", "c"}
any(count: atMost(42))    // Matches any collection with at most 42 elements
notEmpty()                // Matches any non-empty collection
```

#### Match Floating Point Values

Mathematical operations on floating point numbers can cause unexpected behavior, so consider using `around` to fuzzily match floating point arguments with some tolerance.

```swift
around(10.0, tolerance: 0.01)
```

### 5. Miscellaneous

#### Excluding Files

You can exclude unwanted or problematic sources from being mocked by adding a `.mockingbird-ignore` file. Mockingbird follows the same pattern format as [`.gitignore`](https://git-scm.com/docs/gitignore#_pattern_format) and scopes ignore files to their enclosing directory.

#### Using Supporting Source Files

Supporting source files are used by the generator to resolve inherited types defined outside of your project. Although Mockingbird provides a preset “starter pack” for basic compatibility with common system frameworks, you will occasionally need to add your own definitions for third-party library types. Please see [Supporting Source Files](https://github.com/birdrides/mockingbird/wiki/Supporting-Source-Files) for more information.

## Mockingbird CLI

### Generate

Generate mocks for a set of targets in a project.

`mockingbird generate` 

| Option | Default Value | Description | 
| --- | --- | --- |
| `--project` | [`(inferred)`](#--project) | Path to your project’s `.xcodeproj` file. |
| `--targets` | `$TARGET_NAME` | List of target names to generate mocks for. |
| `--srcroot` | `$SRCROOT` | The folder containing your project’s source files. |
| `--outputs` | [`(inferred)`](#--outputs) | List of mock output file paths for each target. |
| `--support` | [`(inferred)`](#--support) | The folder containing [supporting source files](https://github.com/birdrides/mockingbird/wiki/Supporting-Source-Files). |
| `--condition` | `(none)` | [Compilation condition](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID538) to wrap all generated mocks in, e.g. `DEBUG`. |
| `--diagnostics` | `(none)` | List of [diagnostic generator warnings](https://github.com/birdrides/mockingbird/wiki/Diagnostic-Warnings-and-Errors) to enable. |

| Flag | Description |
| --- | --- |
| `--disable-module-import` | Omit `@testable import <module>` from generated mocks. |
| `--only-protocols` | Only generate mocks for protocols. |
| `--disable-swiftlint` | Disable all SwiftLint rules in generated mocks. |
| `--disable-cache` | Ignore cached mock information stored on disk. |
| `--disable-relaxed-linking` | Only search explicitly imported modules. |

### Install

Configure a test target to use mocks.

`mockingbird install`

| Option | Default Value | Description |
| --- | --- | --- |
| `--target` | *(required)* | The name of a test target to configure. |
| `--sources` | *(required)* | List of target names to generate mocks for. |
| `--project` | [`(inferred)`](#--project) | Your project’s `.xcodeproj` file. |
| `--srcroot` |  `<project>/../` | The folder containing your project’s source files. |
| `--outputs` | [`(inferred)`](#--outputs) | List of mock output file paths for each target. |
| `--support` | [`(inferred)`](#--support) | The folder containing [supporting source files](https://github.com/birdrides/mockingbird/wiki/Supporting-Source-Files). |
| `--condition` | `(none)` | [Compilation condition](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID538) to wrap all generated mocks in, e.g. `DEBUG`. |
| `--diagnostics` | `(none)` | List of [diagnostic generator warnings](https://github.com/birdrides/mockingbird/wiki/Diagnostic-Warnings-and-Errors) to enable. |
| `--loglevel` |  `(none)` | The log level to use when generating mocks, `quiet` or `verbose` |

| Flag | Description |
| --- | --- |
| `--preserve-existing` | Don’t overwrite previously installed configurations. |
| `--asynchronous` | Generate mocks asynchronously in the background when building. |
| `--only-protocols` | Only generate mocks for protocols. |
| `--disable-swiftlint` | Disable all SwiftLint rules in generated mocks. |
| `--disable-cache` | Ignore cached mock information stored on disk. |
| `--disable-relaxed-linking` | Only search explicitly imported modules. |

### Uninstall

Remove Mockingbird from a test target.

`mockingbird uninstall`

| Option | Default Value | Description |
| --- | --- | --- |
| `--targets` | *(required)* | List of target names to uninstall the Run Script Phase. |
| `--project` | [`(inferred)`](#--project) | Your project’s `.xcodeproj` file. |
| `--srcroot` |  `<project>/../` | The folder containing your project’s source files. |

### Download

Download and unpack a compatible asset bundle. Bundles will never overwrite existing files on disk.

`mockingbird download <asset>`

| Asset | Description |
| --- | --- |
| `starter-pack` | Starter [supporting source files](https://github.com/birdrides/mockingbird/wiki/Supporting-Source-Files). |

### Global Options

| Flag | Description |
| --- | --- |
| `--verbose` | Log all errors, warnings, and debug messages. |
| `--quiet` | Only log error messages. |

### Inferred Paths

#### `--project`

Mockingbird will first check if the environment variable `$PROJECT_FILE_PATH` was set (usually by an Xcode build context). It will then perform a shallow search of the current working directory for an `.xcodeproj` file. If multiple `.xcodeproj` files exist then you must explicitly provide a project file path.

#### `--outputs`

By default Mockingbird will generate mocks into the `$(SRCROOT)/MockingbirdMocks` directory with the file name `$(PRODUCT_MODULE_NAME)Mocks.generated.swift`.

#### `--support`

Mockingbird will recursively look for [supporting source files](https://github.com/birdrides/mockingbird/wiki/Supporting-Source-Files) in the `$(SRCROOT)/MockingbirdSupport` directory.

## Additional Resources

### Examples and Tutorials

- [CocoaPods tutorial + example project](/Examples/iOSMockingbirdExample-CocoaPods)
- [Carthage tutorial + example project](/Examples/iOSMockingbirdExample-Carthage)
- [Swift Package Manager tutorial + example project](/Examples/iOSMockingbirdExample-SPM)

### Help and Documentation

- [Slack channel](https://slofile.com/slack/birdopensource)
- [Troubleshooting guide](https://github.com/birdrides/mockingbird/wiki/Troubleshooting)
- [Mockingbird wiki](https://github.com/birdrides/mockingbird/wiki/)
