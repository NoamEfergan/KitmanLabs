//
//  UserDefaults+Extensions.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import Foundation

// MARK: - UserDefault
@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional,
               optional.isNil {
                container.removeObject(forKey: key)
            } else {
                container.set(newValue, forKey: key)
            }
        }
    }
}

// MARK: - AnyOptional
/// Allows to match for optionals with generics that are defined as non-optional.
public protocol AnyOptional {
    /// Returns `true` if `nil`, otherwise `false`.
    var isNil: Bool { get }
}

// MARK: - Optional + AnyOptional
extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

// MARK: - Key
enum Key: String {
    var id: String { UUID().uuidString }
    case name

    func getId() -> String {
        switch self {
        case .name:
            return "userName"
        }
    }
}

// MARK: - UserDefaults

extension UserDefaults {
    @UserDefault(key: Key.name.getId(),
                 defaultValue: "User")
    static var userName: String
}
