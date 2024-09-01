//
//  StatefulBody.swift
//  JustDesserts
//
//  Created by Jey Starratt on 9/1/24.
//

import SwiftUI

/// Wrapper for showing contents based on a ViewState.
struct StatefulBody<Content: View>: View {
    /// The current state of the UI.
    var state: ViewState

    /// The action to be performed if a user pulls to refresh.
    var refresh: @Sendable () async -> ()

    /// The content to be shown for this specific view.
    @ViewBuilder let content: Content

    var body: some View {
        ZStack {
            List {
                if state == .success {
                    content
                } else {
                    HStack {
                        Spacer()

                        if case .error(let error) = state {
                            error.errorDescription
                                .padding()
                                .background(.regularMaterial)
                                .clipShape(Capsule())
                                .accessibilityLabel(error.errorDescription)
                        } else {
                            // A more "on theme" progress indicator.
                            Image(systemName: "alarm.waves.left.and.right")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                                .symbolEffect(.variableColor.iterative.dimInactiveLayers.reversing)
                                .accessibilityRemoveTraits([.isImage])
                                .accessibilityLabel(Text(NSLocalizedString("Loading", comment: "Informs the user that the UI is currently loading.")))
                        }

                        Spacer()
                    }
                }
            }
            .refreshable(action: refresh)
        }
    }
}
