//
//  MealsViewModel.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import SwiftUI

/// Describes a data source that can provide meals information.
protocol MealsLoadable {
    var mealDB: MealDB { get }

    var state: ViewState { get }

    var meals: [Meal] { get }

    func load(cached: Bool) async
}

extension MealsView {
    @Observable
    class ViewModel: MealsLoadable {
        let mealDB: MealDB

        var state = ViewState.idle

        var meals: [Meal] = []

        init(mealDB: MealDB) {
            self.mealDB = mealDB
        }

        func load(cached: Bool) async {
            // Only if we were idle do we show the full loading state.
            if state == .idle { state = .loading }

            do {
                // They seem already in alphabetical order, but not taking a chance.
                meals = try await mealDB.desserts(cached: cached).alphabetical()
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
    class MockViewModel: MealsLoadable {
        let mealDB = MealDB()

        var state = ViewState.success

        var meals: [Meal] = [
            Meal(id: "53049", name: "Apam balik", thumbnail: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"),
            Meal(id: "52893", name: "Apple & Blackberry Crumble", thumbnail: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg"),
            Meal(id: "52768", name: "Apple Frangipan Tart", thumbnail: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg"),
            Meal(id: "52767", name: "Bakewell tart", thumbnail: "https://www.themealdb.com/images/media/meals/wyrqqq1468233628.jpg"),
            Meal(id: "52855", name: "Banana Pancakes", thumbnail: "https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg"),
        ]

        func load(cached: Bool) async { /* no-op */ }
    }
    #endif
}
