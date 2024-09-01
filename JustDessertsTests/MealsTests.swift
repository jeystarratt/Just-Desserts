//
//  MealsTests.swift
//  JustDessertsTests
//
//  Created by Jey Starratt on 9/1/24.
//

import XCTest
@testable import JustDesserts

final class MealsTests: XCTestCase {
    private struct MealResponse: Codable {
        let meals: [Meal]
    }

    private func dataAsset(name: String) -> NSDataAsset? {
        NSDataAsset(name: name, bundle: Bundle(for: MealsTests.self))
    }

    private let decoder = JSONDecoder()

    func testMealsDecode() throws {
        let data = dataAsset(name: "meals.json")!.data

        let exampleMeal = try XCTUnwrap(decoder.decode(MealResponse.self, from: data).meals.first, "Unable to parse meals response")
        XCTAssertEqual(exampleMeal.name, "Apam Balik")
        XCTAssertEqual(exampleMeal.thumbnail, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        XCTAssertEqual(exampleMeal.id, "53049")
    }

    func testMealDecode() throws {
        let data = dataAsset(name: "meal.json")!.data

        let exampleMeal = try XCTUnwrap(decoder.decode(MealResponse.self, from: data).meals.first, "Unable to parse meal response")
        XCTAssertEqual(exampleMeal.instructions, "Line an 8-inch-square baking pan with wax paper or foil, and coat with non-stick spray.\r\nIn a microwave-safe bowl, combine the dark chocolate chips, heavy cream and half of the sweetened condensed milk. Microwave the dark chocolate mixture in 20-second intervals, stirring in between each interval, until the chocolate is melted.\r\nAdd the vanilla extract to the dark chocolate mixture and stir well until smooth.\r\nTransfer the dark chocolate mixture into the prepared pan and spread into an even layer.\r\nIn a separate bowl, combine the white chocolate chips with the remaining half of the sweetened condensed milk. Microwave the white chocolate mixture in 20-second intervals, stirring in between each interval, until the chocolate is melted.\r\nEvenly spread the white chocolate mixture on top of dark chocolate layer.\r\nTop the chocolate layers with the Mallow Bits or miniature marshmallows, and gently press them down.\r\nRefrigerate for 4 hours, or until set.\r\nRemove the fudge and wax paper from the pan. Carefully peel all of the wax paper from the fudge.\r\nCut the fudge into bite-sized pieces and serve.")
        let exampleIngredient = try XCTUnwrap(exampleMeal.ingredients?.first)
        XCTAssertEqual(exampleIngredient.name, "Chocolate Chips")
        XCTAssertEqual(exampleIngredient.measurement, "2 cups")
    }
}
