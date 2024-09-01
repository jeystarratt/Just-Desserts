//
//  JustDessertsApp.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import SwiftUI

@main
struct JustDessertsApp: App {
    var body: some Scene {
        WindowGroup {
            MealsView(viewModel: MealsView.ViewModel(mealDB: MealDB()))
        }
    }
}
