//
//  MainView.swift
//  MonstarHubSwiftUI
//
//  Created by Rokon on 11/9/21.
//

import SwiftUI
import AppSetting
import Authentication
import TrendingDeveloper
import TrendingRepository
import ComposableArchitecture

public struct RootView: View {
    let store: StoreOf<Root>
    
    public init(store: StoreOf<Root>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            if viewStore.state.authenticationState.isSignIn {
                TabView {
                    TrendingRepositoryView(
                        store: store.scope(state: \.trendingRepositoryState,
                                           action: Root.Action.trendingRepositoryAction))
                        .tabItem {
                            Label("Repositories", systemImage: "book.closed.fill")
                        }

                    TrendingDeveloperView(store: store.scope(
                        state: \.trendingDevelopersState,
                        action: Root.Action.trendingDevelopersAction
                    ))
                    .tabItem {
                        Label("Developers", systemImage: "person.fill")
                    }

                    AppSettingView(store: store.scope(
                        state: \.settingState,
                        action: Root.Action.appSettingAction
                    ))
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                }
                .onAppear(perform: {
                    if #available(iOS 15.0, *) {
                        let appearance = UITabBarAppearance()
                        UITabBar.appearance().scrollEdgeAppearance = appearance
                    }
                })
                .padding(.top, 10)
            } else {
                SignInRepositoryView(store:
                    store.scope(state: \.authenticationState,
                                action: Root.Action.authenticationAction))
            }
        }
    }
}
