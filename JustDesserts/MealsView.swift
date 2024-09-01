//
//  MealsView.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import SwiftUI

/// Lists all the meals available (in this case, hardcoded to desserts).
struct MealsView: View {
    @State private var viewModel: MealsLoadable

    init(viewModel: MealsLoadable) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            StatefulBody(state: viewModel.state, refresh: { await viewModel.load(cached: false) }) {
                ForEach(viewModel.meals) { meal in
                    NavigationLink(value: meal) {
                        HStack {
                            AsyncImage(url: URL(string: meal.thumbnail)) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.primary.opacity(0.75), lineWidth: 1))

                            Text(meal.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .contentShape(Rectangle())
                        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                    }
                }
            }
            .navigationTitle(NSLocalizedString("Desserts", comment: "Title above a list of desserts"))
            .navigationDestination(for: Meal.self) { meal in
                MealDetailsView(viewModel: MealDetailsView.ViewModel(mealDB: viewModel.mealDB, meal: meal))
            }
            .task {
                guard viewModel.state == .idle else { return }
                await viewModel.load(cached: true)
            }
        }
    }
}

#if DEBUG
struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView(viewModel: MealsView.MockViewModel())

        MealsView(viewModel: MealsView.MockViewModel())
            .preferredColorScheme(.dark)

        MealsView(viewModel: MealsView.MockViewModel())
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
#endif
