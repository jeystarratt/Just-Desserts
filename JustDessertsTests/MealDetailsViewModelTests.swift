//
//  MealDetailsViewModelTests.swift
//  JustDessertsTests
//
//  Created by Jey Starratt on 9/1/24.
//

import XCTest
@testable import JustDesserts

final class MealDetailsViewModelTests: XCTestCase {
    func testIngredients() {
        let viewModel = MealDetailsView.MockViewModel()
        XCTAssertEqual(viewModel.ingredients, [
            Ingredient(id: "1", name: "Chocolate Chips", measurement: "2 cups"),
            Ingredient(id: "3", name: "Condensed Milk", measurement: "1 \u{2013} 14-ounce can"),
            Ingredient(id: "2", name: "Heavy Cream", measurement: "2 tbs"),
            Ingredient(id: "6", name: "Miniature Marshmallows", measurement: "1-\u{00bd} cups"),
            Ingredient(id: "4", name: "Vanilla Extract", measurement: "1 tsp"),
            Ingredient(id: "5", name: "White Chocolate Chips", measurement: "1-\u{2153} cups"),
        ])
    }
}
