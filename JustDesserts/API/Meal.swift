//
//  Meal.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import Foundation

/// A recipe that contains a preview, at minimum.
struct Meal: Codable {
    let id: String

    let name: String

    let thumbnail: String

    let instructions: String?

    let ingredients: [Ingredient]?

    init(id: String, name: String, thumbnail: String, instructions: String? = nil, ingredients: [Ingredient]? = nil) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.instructions = instructions
        self.ingredients = ingredients
    }

    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<DynamicCodingKey> = try decoder.container(keyedBy: DynamicCodingKey.self)
        self.id = try container.decode(String.self, forKey: DynamicCodingKey(stringValue: "idMeal")!)
        self.name = try container.decode(String.self, forKey: DynamicCodingKey(stringValue: "strMeal")!).localizedCapitalized
        self.thumbnail = try container.decode(String.self, forKey: DynamicCodingKey(stringValue: "strMealThumb")!)
        self.instructions = try container.decodeIfPresent(String.self, forKey: DynamicCodingKey(stringValue: "strInstructions")!)
        // Assumption: there is a max of 20.
        var ingredients: [Ingredient] = []
        for count in (1...20) {
            guard
                let name = try container.decodeIfPresent(String.self, forKey: DynamicCodingKey(stringValue: "strIngredient\(count)")!),
                let measure = try container.decodeIfPresent(String.self, forKey: DynamicCodingKey(stringValue: "strMeasure\(count)")!),
                name.isEmpty == false && measure.isEmpty == false else { break }
            ingredients.append(Ingredient(id: String(count), name: name.localizedCapitalized, measurement: measure))
        }
        // [JRS] I couldn't figure out any consistent pattern on how this is formatted, so showing it "raw."
        self.ingredients = ingredients
    }

    // To be able to generate stringly typed keys.
    private struct DynamicCodingKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            nil // no-op
        }
    }
}

// [JRS] The idea being that this is only done within the app itself and not at the network layer.
extension Meal: Identifiable, Hashable { }
