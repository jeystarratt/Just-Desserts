//
//  MealDetailsView.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import SwiftUI

/// Lists all the steps and ingredients needed for a given meal.
struct MealDetailsView: View {
    @State private var viewModel: MealLoadable

    init(viewModel: MealLoadable) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        StatefulBody(state: viewModel.state, refresh: { await viewModel.load(cached: false) }) {
            Section(NSLocalizedString("Ingredients", comment: "Title above a list of ingredients")) {
                ForEach(viewModel.ingredients) { ingredient in
                    LabeledContent(ingredient.name, value: ingredient.measurement)
                }
            }

            Section(NSLocalizedString("Instructions", comment: "Title above a list of instructions")) {
                Text(viewModel.meal.instructions ?? "")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.meal.name)
        .task {
            guard viewModel.state == .idle else { return }
            await viewModel.load(cached: true)
        }
    }
}

#if DEBUG
struct MealDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailsView(viewModel: MealDetailsView.MockViewModel())

        MealDetailsView(viewModel: MealDetailsView.MockViewModel())
            .preferredColorScheme(.dark)

        MealDetailsView(viewModel: MealDetailsView.MockViewModel())
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
#endif
