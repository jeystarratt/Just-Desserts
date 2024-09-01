//
//  Array.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import Foundation

extension Array where Element == Meal {
    func alphabetical() -> [Meal] {
        sorted(by: { $0.name.localizedStandardCompare($1.name) == .orderedAscending })
    }
}

extension Array where Element == Ingredient {
    func alphabetical() -> [Ingredient] {
        sorted(by: { $0.name.localizedStandardCompare($1.name) == .orderedAscending })
    }
}
