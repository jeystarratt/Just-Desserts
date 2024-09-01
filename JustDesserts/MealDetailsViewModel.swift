//
//  MealDetailsViewModel.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import SwiftUI

/// Describes a data source that can provide meal information.
protocol MealLoadable {
    var state: ViewState { get }

    var meal: Meal { get }

    var ingredients: [Ingredient] { get }

    func load(cached: Bool) async
}

extension MealDetailsView {
    @Observable
    class ViewModel: MealLoadable {
        let mealDB: MealDB

        var state = ViewState.idle

        var meal: Meal

        init(mealDB: MealDB, meal: Meal) {
            self.mealDB = mealDB
            self.meal = meal
        }

        var ingredients: [Ingredient] {
            meal.ingredients?.alphabetical() ?? []
        }

        func load(cached: Bool) async {
            // Only if we were idle do we show the full loading state.
            if state == .idle { state = .loading }

            do {
                meal = try await mealDB.mealDetails(for: meal.id, cached: cached)
                state = .success
            } catch {
                guard let underlyingError = error as? MealDBError else {
                    state = .error(MealDBError.failed)
                    return
                }
                state = .error(underlyingError)
            }
        }
    }

    #if DEBUG
    /// For Previews.
    class MockViewModel: MealLoadable {
        var state = ViewState.success

        var meal = Meal(id: "52787", name: "Hot Chocolate Fudge", thumbnail: "https://www.themealdb.com/images/media/meals/xrysxr1483568462.jpg", instructions: "Line an 8-inch-square baking pan with wax paper or foil, and coat with non-stick spray.\r\nIn a microwave-safe bowl, combine the dark chocolate chips, heavy cream and half of the sweetened condensed milk. Microwave the dark chocolate mixture in 20-second intervals, stirring in between each interval, until the chocolate is melted.\r\nAdd the vanilla extract to the dark chocolate mixture and stir well until smooth.\r\nTransfer the dark chocolate mixture into the prepared pan and spread into an even layer.\r\nIn a separate bowl, combine the white chocolate chips with the remaining half of the sweetened condensed milk. Microwave the white chocolate mixture in 20-second intervals, stirring in between each interval, until the chocolate is melted.\r\nEvenly spread the white chocolate mixture on top of dark chocolate layer.\r\nTop the chocolate layers with the Mallow Bits or miniature marshmallows, and gently press them down.\r\nRefrigerate for 4 hours, or until set.\r\nRemove the fudge and wax paper from the pan. Carefully peel all of the wax paper from the fudge.\r\nCut the fudge into bite-sized pieces and serve.", ingredients: [
            Ingredient(id: "1", name: "Chocolate Chips", measurement: "2 cups"),
            Ingredient(id: "2", name: "Heavy Cream", measurement: "2 tbs"),
            Ingredient(id: "3", name: "Condensed Milk", measurement: "1 \u{2013} 14-ounce can"),
            Ingredient(id: "4", name: "Vanilla Extract", measurement: "1 tsp"),
            Ingredient(id: "5", name: "White Chocolate Chips", measurement: "1-\u{2153} cups"),
            Ingredient(id: "6", name: "Miniature Marshmallows", measurement: "1-\u{00bd} cups"),
        ])

        var ingredients: [Ingredient] { meal.ingredients?.alphabetical() ?? [] }

        func load(cached: Bool) async { /* no-op */ }
    }
    #endif
}
