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
    let key: Key
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            container.object(forKey: key.id) as? Value ?? defaultValue
        }
        set {
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional,
               optional.isNil {
                container.removeObject(forKey: key.id)
            } else {
                container.set(newValue, forKey: key.id)
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

// MARK: - UserDefault.Key
extension UserDefault {
    enum Key: String {
        var id: String { UUID().uuidString }
        case name
    }
}

// MARK: - UserDefaults

extension UserDefaults {
    @UserDefault(key: .name,
                 defaultValue: "User")
    static var userName: String
}
