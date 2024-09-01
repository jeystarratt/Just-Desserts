//
//  ViewState.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import Foundation

/// Describes the current state of the UI.
enum ViewState: Equatable {
    /// The view has not attempted to load data yet.
    case idle

    /// The view is currently loading data.
    case loading

    /// The view has successfully loaded data.
    case success

    /// The view encountered an error.
    case error(MealDBError)
}
