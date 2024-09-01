//
//  Ingredient.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import Foundation

/// The combination of an ingredient type and its measurement.
struct Ingredient: Codable {
    /// Some ingredients are duplicated. Not knowing if this is intentional, storing an ID to help with view identity.
    let id: String

    let name: String

    let measurement: String

    init(id: String, name: String, measurement: String) {
        self.id = id
        self.name = name
        self.measurement = measurement
    }
}

// [JRS] The idea being that this is only done within the app itself and not at the network layer.
extension Ingredient: Identifiable, Hashable { }
