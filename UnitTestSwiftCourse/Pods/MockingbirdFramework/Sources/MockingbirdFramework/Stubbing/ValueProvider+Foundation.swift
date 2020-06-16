//
//  ValueProvider+Foundation.swift
//  MockingbirdFramework
//
//  Created by Andrew Chang on 4/12/20.
//

import Foundation
import CoreGraphics

public extension ValueProvider {
  /// Provides default values for primitive Swift types.
  /// https://developer.apple.com/documentation/foundation/numbers_data_and_basic_values
  static let primitivesProvider = ValueProvider(values: [
    ObjectIdentifier(Bool.self): Bool(),
    ObjectIdentifier(Decimal.self): Decimal(),
    
    // Integers
    ObjectIdentifier(Int.self): Int(),
    ObjectIdentifier(Int8.self): Int8(),
    ObjectIdentifier(Int16.self): Int16(),
    ObjectIdentifier(Int32.self): Int32(),
    ObjectIdentifier(Int64.self): Int64(),
    
    // Unsigned integers
    ObjectIdentifier(UInt.self): UInt(),
    ObjectIdentifier(UInt8.self): UInt8(),
    ObjectIdentifier(UInt16.self): UInt16(),
    ObjectIdentifier(UInt32.self): UInt32(),
    ObjectIdentifier(UInt64.self): UInt64(),
    
    // Floating point
    ObjectIdentifier(Float.self): Float(), // Float32
    ObjectIdentifier(Double.self): Double(), // Float64
  ])
}

extension Optional: Providable {
  public static func createInstance() -> Self? { Optional(nil) }
}

public extension ValueProvider {
  /// Provides default values for basic types that are not primitives.
  /// https://developer.apple.com/documentation/foundation/numbers_data_and_basic_values
  static let basicsProvider = ValueProvider(values: [
    ObjectIdentifier(Data.self): Data(),
    ObjectIdentifier(UUID.self): UUID(),
    ObjectIdentifier(IndexPath.self): IndexPath(),
    ObjectIdentifier(IndexSet.self): IndexSet(),
  ], identifiers: [
    Optional<Any>.providableIdentifier,
  ])
}

public extension ValueProvider {
  /// Provides default values for graphics and geometry types.
  /// https://developer.apple.com/documentation/foundation/numbers_data_and_basic_values
  static let geometryProvider = ValueProvider(values: [
    ObjectIdentifier(CGFloat.self): CGFloat(),
    ObjectIdentifier(CGPoint.self): CGPoint(),
    ObjectIdentifier(CGSize.self): CGSize(),
    ObjectIdentifier(CGRect.self): CGRect(),
  ])
}

public extension ValueProvider {
  /// Provides default values for string and text types.
  /// https://developer.apple.com/documentation/foundation/strings_and_text
  static let stringsProvider = ValueProvider(values: [
    ObjectIdentifier(String.self): String(),
    ObjectIdentifier(NSAttributedString.self): NSAttributedString(),
    ObjectIdentifier(NSMutableAttributedString.self): NSMutableAttributedString(),
    ObjectIdentifier(CharacterSet.self): CharacterSet(),
    ObjectIdentifier(Character.self): "",
  ])
}

public extension ValueProvider {
  /// Provides default values for date and time types.
  /// https://developer.apple.com/documentation/foundation/dates_and_times
  static let datesProvider = ValueProvider(values: [
    ObjectIdentifier(Date.self): Date(),
    ObjectIdentifier(NSDate.self): NSDate(),
    ObjectIdentifier(TimeInterval.self): TimeInterval(),
  ])
}
