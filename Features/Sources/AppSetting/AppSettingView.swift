//
//  AppSettingView.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 29/3/22.
//

import Commons
import SwiftUI
import ComposableArchitecture

public struct AppSettingFeature: ReducerProtocol {
    
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        var showSignOutPrompt: Bool = false
        var alert: AlertState<Action>?
        var signOutAction: AlertState<Action>?
    }

    public enum Action: Equatable {
        case signOutPrompt
        case alertDismissed
        case confirmTapped
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .signOutPrompt:
            state.alert = .init(
                title: TextState("Sign out"),
                message: TextState("Are you sure you want to Sign out this?"),
                primaryButton: .default(TextState("Confirm"), action: .send(.confirmTapped)),
                secondaryButton: .cancel(TextState("Cancel"))
            )
        case .alertDismissed:
            state.alert = nil
        case .confirmTapped:
            AppPersistence.isSignIn = false
        }
        return .none
    }
}

public struct AppSettingView: View {
    let store: StoreOf<AppSettingFeature>
    
    public init(store: StoreOf<AppSettingFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    Section(header: Text("Account")) {
                        NavigationLink(destination: EmptyView(), label: {
                            SettingRowView(title: "My Account",
                                           systemImageName: "person")
                        })
                    }

                    Section(header: Text("")) {
                        Button {
                            viewStore.send(.signOutPrompt)
                        } label: {
                            SettingRowView(title: "Sign Out",
                                           systemImageName: "arrow.backward.circle")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle(Text("Settings"))
            }
            .alert(self.store.scope(state: \.alert), dismiss: .alertDismissed)
        }
    }
}

struct SettingRowView: View {
    var title: String
    var systemImageName: String
    var body: some View {
        Text(title)
    }
}
