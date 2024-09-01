//
//  MealDBError.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import SwiftUI

/// General purpose errors from TheMealDB API.
enum MealDBError: Error {
    /// A response we didn't anticipate.
    case badResponse

    /// A URL we weren't expecting to be formed.
    case badURL

    /// General failure.
    case failed

    var errorDescription: Text {
        switch self {
        case .badResponse:
            return Text(NSLocalizedString("Encountered a bad response.", comment: ""))
        case .badURL:
            return Text(NSLocalizedString("Encountered a bad URL.", comment: ""))
        case .failed:
            return Text(NSLocalizedString("Failed to retrieve data.", comment: ""))
        }
    }
}
